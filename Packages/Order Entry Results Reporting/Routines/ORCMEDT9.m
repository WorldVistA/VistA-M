ORCMEDT9 ;SLC/WAT - Move/copy utility for QOs ;09/08/15  06:20
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**389**;Dec 17, 1997;Build 17
UDQO ; -- unit dose quick order
 N ORQDLG,ORDG,ORCMDG,ORCIDG,ORABORT,ORPMAX,ORINDEX
 S ORABORT=0,ORPMAX=IOSL-5,ORINDEX=""
 S ORCMDG=$O(^ORD(100.98,"B","CLINIC MEDICATIONS",""))
 S ORCIDG=$O(^ORD(100.98,"B","CLINIC INFUSIONS",""))
 I +$G(ORCMDG)'>0 W !,"Abort: Clinic Medications display group not found!" Q
 I +$G(ORCIDG)'>0 W !,"Abort: Clinic Infusions display group not found!" Q
 D BLDUDQO
 F  D  Q:ORABORT=1
 . D DISP(ORPMAX,.ORINDEX)
 . D CHOOSE(.ORABORT)
 D CLEAN^DILF
 Q
 ;
CHOOSE(ORABORT) ;select qo for action
 N ORQO,ORACT
 N DIR,X,Y,DIRUT,DTOUT,DUOUT
 S DIR(0)="LO"
 D ^DIR
 I $D(DTOUT) S ORABORT=1 Q
 I $D(DUOUT) S ORABORT=1 Q
 Q:X=""
 I X'[","&(X'["-")&($D(^TMP("ORUDQO",$J,X))) D  Q  ;single selection can Move OR Copy
 . S ORACT=$$ACTASK
 . I ORACT="^" S ORABORT=1 Q
 . E  D ACTION(ORACT,X)
 I X[","!(X["-") D ACTION(1,Y) ;check for series of numbers. Move only
 Q
 ;
ACTION(ORGO,ORNUMBER) ;
 ;ORGO=1 MOVE, ORGO=2 COPY
 N ORTEMP,ORCOUNT
 I $G(ORGO)=2 D COPY^ORCMEDT9(ORNUMBER) Q
 S:$G(ORCMDG)="" ORCMDG=$O(^ORD(100.98,"B","CLINIC MEDICATIONS",""))
 S ORCOUNT=1
 F  S ORTEMP=$P(ORNUMBER,",",ORCOUNT) Q:$G(ORTEMP)=""  D
 . I $D(^TMP("ORUDQO",$J,ORTEMP)) D MOVE(ORTEMP)
 . S ORCOUNT=ORCOUNT+1
 Q
 ;
DISP(ORPMAX,ORINDEX) ; show qo dialogs for action choices
 ;^TMP("ORUDQO",$J,1)=12345
 ;                 2)=12346
 N ORDLGNM,ORIFN,ORQONAM,ORDISABL,ORDG
 D HEADER
 S ORIFN=""
 F  S ORINDEX=$O(^TMP("ORUDQO",$J,ORINDEX)) Q:ORINDEX=""  D  Q:$Y>ORPMAX
 . I IOSL-$Y<5 D HEADER
 . S ORQONAM=$P(^TMP("ORUDQO",$J,ORINDEX),U,2),ORQONAM=$E(ORQONAM,1,45)
 . S ORDG=$P(^TMP("ORUDQO",$J,ORINDEX),U,3)
 . S ORDISABL=$P(^TMP("ORUDQO",$J,ORINDEX),U,4)
 . W !,$J(ORINDEX,5)_". "_ORQONAM,?60,ORDG,?70,ORDISABL
 Q
 ;
MOVE(ORQDLG) ;Move changes the DISPLAY GROUP to CLINIC MEDICATIONS or CLINIC INFUSIONS
 ;ORQDLG is the index from ^TMP("ORUDQO",$J,index)=order dialog ifn^order NAME(.01)^DisplayGroup^Disabled
 N ORIFN,ORCONVDG S ORIFN=$P(^TMP("ORUDQO",$J,ORQDLG),U) Q:$G(ORIFN)=""
 I $D(^ORD(101.41,ORIFN,0)) D  Q
 . S ORCONVDG=$P(^TMP("ORUDQO",$J,ORQDLG),U,3)
 . S ORCONVDG=$S(ORCONVDG="UDM":ORCMDG,1:ORCIDG)
 . S $P(^ORD(101.41,ORIFN,0),U,5)=$G(ORCONVDG)
 . I $D(^TMP("ORUDQO",$J,ORQDLG)) K ^TMP("ORUDQO",$J,ORQDLG)
 E  W $C(7),!,"Abort: Order dialog not found - check file entry and try again."
 Q
COPY(ORQDLG) ;copy creates a new CLINIC MEDICATIONS or CLINIC INFUSIONS qo dialog and will ask to delete the original qo
 ;ORQDLG is the index from ^TMP("ORUDQO",$J,index)=order dialog ifn^order NAME(.01)^DisplayGroup^Disabled
 N ORQIFN,ORNUNAME,ORNUIFN,ORCUR0,ORESULT,ORPOINT,OR30350,ORTMPDLG,ORDIGP
 S OR30350=$$PATCH^XPDUTL("OR*3.0*350") ;no delete if 350 not installed
 S ORQIFN=$P(^TMP("ORUDQO",$J,ORQDLG),U) Q:+$G(ORQIFN)'>0
 S ORDIGP=$P(^TMP("ORUDQO",$J,ORQDLG),U,3)
 S ORDIGP=$S(ORDIGP="UDM":ORCMDG,1:ORCIDG)
 Q:'$D(^ORD(101.41,ORQIFN,0))
 S ORNUNAME=$$GETNAME() I $G(ORNUNAME)="^" S ORQDLG=ORNUNAME Q
 S ORNUIFN=$$STUB(101.41,ORNUNAME) I +$G(ORNUIFN)'>0 W !,"Error creating new entry. Please try again later."  S ORESULT=0 Q ORESULT
 N I,DA,DIE,DR,DIK,ORTEMP
 S ORCUR0=^ORD(101.41,ORQIFN,0) ;get 0 node of current QO
 F I=2,4,6,8,9 S $P(^ORD(101.41,ORNUIFN,0),U,I)=$P(ORCUR0,U,I)
 S $P(^ORD(101.41,ORNUIFN,0),U,5)=$G(ORDIGP)
 S:$L($P(ORCUR0,U,2)) ^ORD(101.41,"C",$$UP^XLFSTR($P(ORCUR0,U,2)),ORNUIFN)="" ;disp text
 F I=2,3,3.1,4,5,6,7,9,10 I $D(^ORD(101.41,ORQIFN,I)) M ^ORD(101.41,ORNUIFN,I)=^ORD(101.41,ORQIFN,I)
 I $P(ORCUR0,U,7) S ORTEMP=$P(ORCUR0,U,7),DA=ORNUIFN,DIE="^ORD(101.41,",DR="7///^S X=ORTEMP;99///^S X=$H" D ^DIE
 K DA S DA(1)=ORNUIFN,DIK="^ORD(101.41,"_ORNUIFN_",10,",DIK(1)="2^AD" D ENALL^DIK
 S ORESULT=1
 I ($G(OR30350)=1) D  Q ORQDLG
 . S ORPOINT=$$PTRCHECK(ORQIFN) I +$G(ORPOINT)>0 D  Q
 . . S ORQDLG="^"
 . . D CONT
 . Q:$G(ORQDLG)="^"
 . I '$$DELOK() W !,"OK. You can manually delete the QO later via the QO editor." S ORQDLG="^" Q
 . W !,"Now deleting original quick order..."
 . S ORESULT=$$DELETE(ORQIFN)
 . I $G(ORESULT)'="@" W !,"Error deleting IEN "_ORQIFN_" from ORDER DIALOG (101.41)."
 . E  I $D(^TMP("ORUDQO",$J,ORQDLG)) K ^TMP("ORUDQO",$J,ORQDLG)
 Q ORQDLG
 ;
BLDUDQO ;build list of UDM and IVM qos
 N ORUDMDG,ORIVMED,ORDLGNM,ORIFN,ORINDEX,ORDISABL,ORDG
 S ORINDEX=1,ORDLGNM=""
 S ORUDMDG=$O(^ORD(100.98,"B","UNIT DOSE MEDICATIONS",""))
 S ORIVMED=$O(^ORD(100.98,"B","IV MEDICATIONS",""))
 Q:$G(ORUDMDG)=""!($G(ORIVMED)="")
 K ^TMP("ORUDQO",$J)
 F  S ORDLGNM=$O(^ORD(101.41,"B",ORDLGNM))  Q:$G(ORDLGNM)=""  D
 . S ORIFN=$O(^ORD(101.41,"B",ORDLGNM,""))
 . Q:+$G(ORIFN)'>0
 . Q:$P($G(^ORD(101.41,ORIFN,0)),U,5)'=ORUDMDG&($P($G(^ORD(101.41,ORIFN,0)),U,5)'=ORIVMED)!($P($G(^ORD(101.41,ORIFN,0)),U,5)="")
 . Q:$P($G(^(0)),U,4)'="Q"
 . Q:$E($P($G(^(0)),U),1,6)="ORWDQ "
 . S ORDISABL=$P($G(^(0)),U,3)
 . S ORDG=$P($G(^(0)),U,5) S ORDG=$S(ORDG=ORUDMDG:"UDM",ORDG=ORIVMED:"IVM",1:"")
 . S ORDISABL=$S($L($G(ORDISABL))>0:"YES",1:"")
 . S ^TMP("ORUDQO",$J,ORINDEX)=ORIFN_"^"_$P(^ORD(101.41,ORIFN,0),U)_"^"_ORDG_"^"_ORDISABL,ORINDEX=ORINDEX+1
 Q
 ;
GETNAME() ;get new name for copied dialog
 N DIR,X,Y ;prompt for new NAME .01
 S DIR(0)="F^3:63^",DIR("A")="NAME"
 S DIR("?")="Enter a NAME (between 3 and 63 characters) for the new order dialog."
NM D ^DIR
 I $D(DIRUT)!($D(DUOUT)) S Y="^" Q Y
 I $O(^ORD(101.41,"AB",X,""))'="" W $C(7),!,"Another entry already exists by this name!",! S X="" G NM
 K:X[""""!($A(X)=45) X I $D(X) K:$L(X)>63!($L(X)<3)!'(X'?1P.E) X
 I '$D(X) G NM
 Q Y
PTRCHECK(ORIEN) ; check for pointers if Copy action
 N IHAZPTR S IHAZPTR=0
 I $D(^ORD(101.41,"AD",ORIEN)) S IHAZPTR=1 W $C(7),!,"Cannot delete order dialog - currently in use!",! Q IHAZPTR
 S IHAZPTR=$$PTRCHK^ORCMEDT4(ORIEN,"QO PTRS")
 I IHAZPTR D
 . W $C(7),!,"Cannot delete order dialog - other file entries point to this order dialog!",!
 . D PTRRPT^ORCMEDT4("QO PTRS",ORIEN)
 Q IHAZPTR
 ;
ACTASK() ; get action Move or Copy
 N DIR,X,Y
 S DIR(0)="S^1:MOVE;2:COPY"
 S DIR("?")="Choose an action for this quick order"
 S DIR("?",1)="Move converts the selected QO into a new Clinic Medication QO."
 S DIR("?",2)="Copy clones the selected QO into a new Clinic Medication QO."
 S DIR("?",3)="The original QO is then deleted."
 D ^DIR
 S:$D(DTOUT)!($D(DUOUT)) Y="^"
 Q Y
 ;
DELETE(IFN) ;remove old QO;
 N Y,DA,DIK,IDX1,IDX2 S (IDX1,Y)=0
 F  S IDX1=$O(^ORD(101.44,"C",IFN,IDX1)) Q:'IDX1  D
 . S IDX2=0
 . F  S IDX2=$O(^ORD(101.44,"C",IFN,IDX1,IDX2)) Q:'IDX2  D
 . . S DA=IDX2,DA(1)=IDX1,DIK="^ORD(101.44,"_IDX1_",10," D ^DIK
 K DA S DA=IFN,DIK="^ORD(101.41," D ^DIK W "  ...deleted." S Y="@"
 Q Y
 ;
STUB(ORFILE,ORNAME) ; create new entry in file
 N FDA,MSG,IEN
 S FDA(ORFILE,"+1,",.01)=ORNAME
 D UPDATE^DIE("","FDA","IEN","MSG")
 I $D(MSG)>0
 D CLEAN^DILF
 Q IEN(1)
 ;
CONT() ; -- gives user a chance to read output from pointer check
 N X,Y,DIR
 S DIR(0)="FO",DIR("A")="Enter to continue "
 D ^DIR
 Q
DELOK() ; -- Are you ready?
 N X,Y,DIR
 S DIR(0)="YA",DIR("A")="Do you want to delete the original quick order? ",DIR("B")="NO"
 W ! D ^DIR
 Q +Y
HEADER ;header
 W @IOF
 W ".......Quick Order",$$REPEAT^XLFSTR(".",42),?60,"Type...",?67,"Disabled....."
 Q
