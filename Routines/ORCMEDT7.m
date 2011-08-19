ORCMEDT7 ;SLC/JM-QO,Edit Quick Orders By User ;2/1/06
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**245**;Dec 17, 1997;Build 2
 Q
QCKBYUSR ; Edit quick orders by user
 N ORDGINFO,ORTEXT,ORIEN,ORFMDATA,ORUSER,ORDG,ORLINE0
 K ^TMP("ORWDQUSR",$J)
 S ORUSER=0
 F  S ORDGINFO=$$QCKUSRDG(ORUSER) Q:ORDGINFO=0  S:ORDGINFO<0 ORUSER=0 I +ORDGINFO>0,$D(^ORD(101.41,+ORDGINFO,0)) D
 . S ORIEN=$P(ORDGINFO,U,1)
 . S ORFMDATA=$P(ORDGINFO,U,2)
 . S ORUSER=$P(ORDGINFO,U,3)
 . S ORLINE0=$G(^ORD(101.41,ORIEN,0))
 . S ORTEXT=$P(ORLINE0,U,2)
 . S ORDG=+$P(ORLINE0,U,5)
 . D QCK0^ORCMEDT1(ORIEN) ; edit quick order
 . D VERIFYDA(.ORFMDATA,ORIEN)
 . I +ORFMDATA D
 . . ; If quick order not deleted, and display text changes, change 101.44 display text to match
 . . I $D(^ORD(101.41,ORIEN,0)),ORTEXT'=$P(^ORD(101.41,ORIEN,0),U,2) D
 . . . N DIE,DA,DR,DIDEL
 . . . S DA(1)=$P(ORFMDATA,";",1)
 . . . S DIE="^ORD(101.44,"_DA(1)_",10,"
 . . . S DA=$P(ORFMDATA,";",2)
 . . . ; 101.44 Display text holds 132 chars, 101.41 only 80. so this is ok
 . . . S DR="2///"_$P(^ORD(101.41,ORIEN,0),U,2)
 . . . D ^DIE
 . K ^TMP("ORWDQUSR",$J,"A",ORUSER) ; Force reload of user Quick Order info
 . W !
 K ^TMP("ORWDQUSR",$J)
 Q
QCKUSRDG(ORLSTUSR) ; Get quick order dialog by user
 N DIC,DIR,DA,X,Y,ORIDX,ORUSER,ORLEN,ORPRE,ORDIALOG,ORHEADER,ORGROUP,ORCOUNT,USERNAME
 N DTOUT,DUOUT,DIROUT,DIRUT,OREXIT,ORINPUT,ORDGNAME,ORDGIEN,ORLASTGP,ORFMDATA,ORFIRST
 S ORDIALOG=0
 S ORUSER=$$GETUSER(ORLSTUSR)
 I ORUSER>0 D
 . S ORPRE="ORWDQ USR"_ORUSER,ORLEN=$L(ORPRE)
 . S ORIDX=$O(^ORD(101.44,"B",ORPRE))
 . I $E(ORIDX,1,ORLEN)=ORPRE D  I 1
 . . D QULIST(ORUSER)
 . . S USERNAME=$P($G(^VA(200,ORUSER,0)),U,1)
 . . S ORHEADER=USERNAME_" personal quick orders:"
 . . S ORCOUNT=0,ORIDX=0,OREXIT=0,ORLASTGP=U,ORFIRST=1
 . . F  S ORIDX=$O(^TMP("ORWDQUSR",$J,"A",ORUSER,ORIDX)) Q:'+ORIDX  D  Q:+OREXIT!(ORDIALOG>0)
 . . . S ORCOUNT=ORCOUNT+1
 . . . I ORCOUNT=1 D
 . . . . I ORFIRST S ORFIRST=0 W !,!
 . . . . W !,ORHEADER,!
 . . . S ORGROUP=$O(^TMP("ORWDQUSR",$J,"A",ORUSER,ORIDX,""))
 . . . S ORDGIEN=$O(^TMP("ORWDQUSR",$J,"A",ORUSER,ORIDX,ORGROUP,""))
 . . . S ORFMDATA=$O(^TMP("ORWDQUSR",$J,"A",ORUSER,ORIDX,ORGROUP,ORDGIEN,""))
 . . . S ORDGNAME=$G(^TMP("ORWDQUSR",$J,"A",ORUSER,ORIDX,ORGROUP,ORDGIEN,ORFMDATA))
 . . . I (ORCOUNT=1)!(ORGROUP'=ORLASTGP) D
 . . . . S ORLASTGP=ORGROUP
 . . . . S ORCOUNT=ORCOUNT+1
 . . . . W ?4,ORGROUP,!
 . . . W ?7,ORIDX,?12,ORDGNAME,!
 . . . I ORCOUNT'<18 D
 . . . . S DIR("A",1)="Press <RETURN> to see more, '^' to exit this list, OR"
 . . . . S ORDIALOG=$$QUIDX()
 . . . . S ORCOUNT=0
 . . I ORDIALOG'>0,'+OREXIT D
 . . . S ORIDX=$O(^TMP("ORWDQUSR",$J,"A",ORUSER,999999),-1)
 . . . I ORIDX<1 D  I 1
 . . . . ; If user had quick orders, but doesn't any more, there will be false positives in "B" xref
 . . . . D QULIST(0)
 . . . . K ^TMP("ORWDQUSR",$J,"B",USERNAME)
 . . . . D SHOWUSRS
 . . . E  D
 . . . . S DIR("A",1)=""
 . . . . S ORDIALOG=$$QUIDX()
 . E  D SHOWUSRS
 Q ORDIALOG
GETUSER(ORUSER) ;
 I +ORUSER Q ORUSER
 N DIC,Y,X,DLAYGO,DINUM
 S DIC="^VA(200,",DIC(0)="AEMQ"
 D ^DIC
 Q +Y
SHOWUSRS ;
 S ORDIALOG=-1 ; Repeats loop
 W !,!,$P($G(^VA(200,ORUSER,0)),U,1)_" does not have any personal quick orders."
 S DIR("A")="Would you like to see a list of users with personal quick orders"
 S DIR(0)="Y",DIR("B")="YES"
 D ^DIR
 I +Y D  I 1
 . W !,!,"   Choose from:",!
 . D QULIST(0)
 . S ORUSER="",ORIDX=2,OREXIT=0
 . F  S ORUSER=$O(^TMP("ORWDQUSR",$J,"B",ORUSER)) Q:OREXIT!(ORUSER="")  D  Q:OREXIT
 . . W "   ",ORUSER,!
 . . S ORIDX=ORIDX+1
 . . I ORIDX=22 D
 . . . S ORIDX=0
 . . . R "   '^' TO STOP: ",ORINPUT:$G(DTIME,300)
 . . . E  S OREXIT=1
 . . . W $C(13),$J("",20),$C(13) Q:OREXIT
 . . . I ORINPUT[U S OREXIT=1
 E  I $D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S ORDIALOG=0
 Q
QUIDX() ; Get quick order dialog info 
 N ORGROUP,ORDGIEN,ORFMDATA,ORRESULT
 S DIR("A")="CHOOSE 1-"_ORIDX_": "
 S DIR(0)="NOA^1:"_ORIDX
 D ^DIR
 I +Y>0,+Y'>ORIDX D  Q ORRESULT
 . S ORGROUP=$O(^TMP("ORWDQUSR",$J,"A",ORUSER,+Y,""))
 . S ORDGIEN=$O(^TMP("ORWDQUSR",$J,"A",ORUSER,+Y,ORGROUP,""))
 . I $$CONFLICT(ORUSER,ORDGIEN) S OREXIT=1,ORRESULT=-1 Q
 . S ORFMDATA=$O(^TMP("ORWDQUSR",$J,"A",ORUSER,+Y,ORGROUP,ORDGIEN,""))
 . S ORRESULT=ORDGIEN_U_ORFMDATA_U_ORUSER
 W !
 I Y[U S OREXIT=1
 Q -1 ; -1 Value repeats the enter name loop / 0 exits loop
QULIST(ORUSER) ; Build user info
 N PRE,ID,LEN
 S PRE="ORWDQ USR"
 I ORUSER=0 D  Q
 . ; "B" node is list of all users with Quick Orders
 . I $D(^TMP("ORWDQUSR",$J,"B")) Q
 . N LASTUSER,USERNAME,USER
 . S LASTUSER=0,ID=PRE,LEN=$L(PRE)
 . F  S ID=$O(^ORD(101.44,"B",ID))  Q:($E(ID,1,LEN)'=PRE)  D
 . . S USER=$P($E(ID,LEN+1,999)," ")
 . . I USER'=LASTUSER D
 . . . S LASTUSER=USER
 . . . S USERNAME=$P($G(^VA(200,USER,0)),U,1)
 . . . S ^TMP("ORWDQUSR",$J,"B",USERNAME)=""
 . Q
 ;
 ; "A" node is list of quick orders for an individual user
 ; Temp array nodes are "ORWDQUSR",$J,"A"
 ;   User IEN, Index Number, Display Group, Quick Order IEN, 101.44 IEN
 ;   Data value is Quick Order Name - (Name can be 132 chars so can't be node)
 ;
 I $D(^TMP("ORWDQUSR",$J,"A",ORUSER)) Q
 N GROUP,IDX,NUMBER,QOINDEX,QCKORDER,ORFMDATA
 S PRE=PRE_ORUSER,ID=PRE,NUMBER=0,LEN=$L(PRE)
 F  S ID=$O(^ORD(101.44,"B",ID))  Q:($E(ID,1,LEN)'=PRE)  D
 . S GROUP=$P(ID," ",3,999)
 . S GROUP=$O(^ORD(100.98,"B",GROUP,0))
 . I +GROUP S GROUP=$P($G(^ORD(100.98,GROUP,0)),U,1)
 . S IDX=$O(^ORD(101.44,"B",ID,0)),QOINDEX=0
 . F  S QOINDEX=$O(^ORD(101.44,IDX,10,QOINDEX)) Q:'+QOINDEX  D
 . . S QCKORDER=$G(^ORD(101.44,IDX,10,QOINDEX,0))
 . . I +QCKORDER,+$D(^ORD(101.41,+QCKORDER)) D
 . . . S NUMBER=NUMBER+1
 . . . S ORFMDATA=IDX_";"_QOINDEX
 . . . S ^TMP("ORWDQUSR",$J,"A",ORUSER,NUMBER,GROUP,$P(QCKORDER,U,1),ORFMDATA)=$P(QCKORDER,U,2)
 Q
VERIFYDA(ORFMDATA,ORIEN) ;
 ; Make sure FileMan pointers are still correct
 ; - may have changes via CPRS GUI or QCK0^ORCMEDT1(ORIEN)
 N IDX1,IDX2,IEN
 S IDX1=$P(ORFMDATA,";",1)
 S IDX2=$P(ORFMDATA,";",2)
 S IEN=$P($G(^ORD(101.44,IDX1,10,IDX2,0)),U,1)
 I IEN=ORIEN Q
 S ORFMDATA=""
 S IDX2=0
 F  S IDX2=$O(^ORD(101.44,IDX1,10,IDX2)) Q:'+IDX2  D  Q:+ORFMDATA
 . I $P($G(^ORD(101.44,IDX1,10,IDX2,0)),U,1)=ORIEN S ORFMDATA=IDX1_";"_IDX2
 Q
CONFLICT(ORUSER,DIALOG) ; Determine if another user shares the personal quick order
 N DG,OTHERS,USR,NAME,ABORT,DIR,Y,DA,X,DTOUT,DUOUT,DIROUT,DIRUT,COUNT,TEMP
 S (DG,ABORT)=0
 F  S DG=$O(^ORD(101.44,"C",DIALOG,DG)) Q:'+DG  D
 . S USR=$P($G(^ORD(101.44,DG,0)),U,1)
 . I $P(USR," ",1)="ORWDQ" D
 . . S USR=$P(USR," ",2)
 . . I $E(USR,1,3)="USR" D
 . . . S USR=$E(USR,4,999)
 . . . I USR'=ORUSER D
 . . . . S NAME=$P($G(^VA(200,USR,0)),U,1)
 . . . . S OTHERS(NAME)=""
 I $D(OTHERS) D
 . S OTHERS($P($G(^VA(200,ORUSER,0)),U,1))=""
 . W !,$C(7),!,!
 . W "             *********************",!
 . W "             *****  WARNING  *****",!
 . W "             *********************",!,!
 . W "  Multiple users share this personal quick order.",!
 . W "  Modifying this personal quick order will change",!
 . W "  it for all of the following users:",!,!
 . S NAME="",COUNT=7
 . F  S NAME=$O(OTHERS(NAME)) Q:NAME=""  D  Q:ABORT
 . . S COUNT=COUNT+1
 . . I COUNT>20 D  Q:ABORT
 . . . S COUNT=0,TEMP=""
 . . . W !
 . . . R "  Press <RETURN> to continue, '^' to exit: ",TEMP:$G(DTIME,300)
 . . . E  S ABORT=1
 . . . W $C(13),$J("",50),$C(13) Q:ABORT
 . . . I (TEMP[U)!$D(DTOUT)!$D(DUOUT)!$D(DIRUT)!$D(DIROUT) S ABORT=1
 . . W "    ",NAME,!
 . I 'ABORT D
 . . S DIR("A")="Are you sure you want to edit this personal quick order? "
 . . S DIR(0)="YA",DIR("B")="NO" W ! D ^DIR
 . . W !
 . . I '+Y S ABORT=1
 Q ABORT
