MCESCONV ;WISC/DCB-Convert PFTs to Electronic Signature ;7/31/96  15:32
 ;;2.3;Medicine;**8**;09/13/1996
CONV ;
 N MCARGDA,MCREL,PDUZ,DRAFT,RELEASE,LOOP,LOCATION,CHECK,CODE2,INFO2
 N SDRAFT,SRELEASE,MCOUNT,XMY,XMSUB,XMDUZ,XMTEXT,REC,PROC,MCARCK
 N STATUS2,MCUTOFDT
 D MCEPROC^MCARE
 S:MCESKEY="MCGIKEY" MCROUT="GI"
 S:$D(^XUSEC(MCESKEY,DUZ)) MCESSEC=1
 S MCNODE=$S(MCFILE=700:2,MCFILE=694:0,1:"")
 S MCPIECE=$S(MCFILE=700:1,MCFILE=694:9,1:"")
 ; for PFT, check if version not 2.2
 I MCFILE=700 D
 .S REC=+$O(^DIC(9.4,"B","MEDICINE",""))
 .S CHECK=+$O(^DIC(9.4,REC,22,"B","2.2",""))
 .I CHECK="" S (MCNODE,MCPIECE)=""
 S:MCFILE=699 MCARCODE=$S(MCESKEY="MCGIKEY":"G",1:"P")
 I '$D(MCESSEC) W !,"You do not have '"_MCESKEY_"' KEY for "_MCROUT_"." D EXIT Q
 I '$D(^XUSEC("MCMANAGER",DUZ)) W !,"You do not have the Manager key" D EXIT Q
 ;W !,"This is a one time execution menu option."
 N DIR S DIR(0)="DAO^:"_DT_":AEX"
 S DIR("A")="Convert all records prior to: "
 S DIR("?")="Enter an exact date less than or equal to today."
 S DIR("?",1)="All records on or prior to this date will be converted."
 S DIR("?",2)="Any records after this date will be left as is."
 W ! D ^DIR S MCUTOFDT=+Y Q:$D(DIRUT)
 W ! D NOW^%DTC
 S LOC="Undefined",MCARGDA=.9,MCOUNT=8,SDRAFT=0,SRELEASE=0,NOW=$E(%,1,12),PDUZ=$$PERSON(MCESKEY),REC="",REC=$O(^DIC(4,"D",DUZ(2),REC))
 S:REC'="" LOC=$P($G(^DIC(4,REC,0)),U,1)
 Q:PDUZ=-1
 S ^TMP("MCAR",$J,1)=Y(0,0)_" has been"
 S ^TMP("MCAR",$J,2)="assigned the responsibility for releasing"
 S ^TMP("MCAR",$J,3)="the procedure results that were released not verified"
 S ^TMP("MCAR",$J,4)="for the "_MCROUT_" procedure file."
 S ^TMP("MCAR",$J,5)="Only procedures on or prior to "_$$FMTE^XLFDT(MCUTOFDT)_" have been updated."
 S ^TMP("MCAR",$J,6)=""
 S ^TMP("MCAR",$J,7)="The following is a list of records that has been assigned a status:"
 S ^TMP("MCAR",$J,8)=""
 W !!,"Your records are being converted.  Please wait!"
 W !,"A mail message will be sent to you with records that are converted."
 W !,"A dot is equal to 5 records."
 F LOOP=1:1 D START Q:MCARGDA=""
 S ^TMP("MCAR",$J,MCOUNT)="",MCOUNT=MCOUNT+1
 I SDRAFT>0 S ^TMP("MCAR",$J,MCOUNT)="Records that have been assigned a draft status: "_SDRAFT,MCOUNT=MCOUNT+1
 I SRELEASE>0 S ^TMP("MCAR",$J,MCOUNT)="Records that have been assigned a released not verified: "_SRELEASE
 S XMSUB="Procedure File Change",XMDUZ="<Installer of Medicine>",XMTEXT="^TMP(""MCAR"","_$J_","
 S:PDUZ'=DUZ XMY(PDUZ)=""
 S XMY(DUZ)=""
 D ^XMD
 K ^TMP("MCAR",$J)
 Q
ESTOON ; Turn ES to ON.
 S:'$D(MCPRO) MCPRO=$E($P(XQY0,U),8,$L($P(XQY0,U)))
 D MCPPROC^MCARP
 I MCESON W !,"Electronic Signature is already on!"
 I '$D(^XUSEC(MCESKEY,DUZ)) W !,"You do not have '"_MCESKEY_"' KEY for "_MCROUT_"." D EXIT Q
 I '$D(^XUSEC("MCMANAGER",DUZ)) W !,"You do not have the Manager key" D EXIT Q
 S TYPE=$P(^MCAR(697.2,MCARP,0),U,4)
 I TYPE="GEN" D SETESON("GEN",14)
 I TYPE="I"!(TYPE="G") D SETESON("G",14),SETESON("I",14)
 I TYPE="P" D SETESON("P",14)
 I TYPE="HI"!(TYPE="H") D SETESON("H",14),SETESON("HI",14)
 S $P(^MCAR(697.2,MCARP,0),U,14)=1
 I 'MCESON W !,"Electronic Signature is now turned on!"
 D EXIT
 Q
SETESON(PROC,PIECE) ; Set ES ON ALL PULM AND GI PROC
 N ORDER S ORDER=""
 F  S ORDER=$O(^MCAR(697.2,"D",PROC,ORDER)) Q:ORDER=""  D
 .S $P(^MCAR(697.2,ORDER,0),U,PIECE)=1
 Q
START ;
 S MCARGDA=$O(^MCAR(MCFILE,MCARGDA))
 S:+MCARGDA=0 MCARGDA="" Q:MCARGDA=""
 N Y S Y=$P($G(^MCAR(MCFILE,MCARGDA,0)),U)\1 I (Y'>0)!(Y>MCUTOFDT) Q
 I MCFILE=691.5,'$D(^MCAR(MCFILE,MCARGDA,"ES")) Q
 Q:$P($G(^MCAR(MCFILE,MCARGDA,"ES")),U,7)'=""
 S DRAFT=PDUZ_"^^"_NOW_"^^^^D^"_NOW_"^^^^^^^"_$P(^MCAR(MCFILE,MCARGDA,0),U,1)
 S RELEASE=PDUZ_"^^"_NOW_"^^^^RNV^"_NOW_"^^^^^^^"_$P(^MCAR(MCFILE,MCARGDA,0),U,1)
 S:MCNODE'="" MCREL=$P($G(^MCAR(MCFILE,MCARGDA,MCNODE)),U,MCPIECE)
 I MCFILE=699 S MCARCK=+$P(^MCAR(699,MCARGDA,0),U,12) I MCARCK=0,$D(^MCAR(697.2,"D",MCARCODE,MCARCK)) Q
 I MCFILE=699.5,('$P(^MCAR(699.5,MCARGDA,0),U,3)),($P(^MCAR(699.5,MCARGDA,0),U,6)=MCARP) Q
 D STATUS
 S ^MCAR(MCFILE,MCARGDA,"ES")=STATUS
 S ^MCAR(MCFILE,"ES",STATUS2,MCARGDA)=""
 I (LOOP\5)=(LOOP/5) W "."
 Q
PERSON(MCESKEY) ; Get a person with the right key.
 W !,"In order to do the conversion, you must select a provider that"
 W !,"has the key to ",MCROUT,!!!!
 S DIC=200,DIC(0)="AEQMZ",DIC("A")="Please select a Provider with a "_MCROUT_" key: ",DIC("S")="I $D(^XUSEC(MCESKEY,Y))"
 S:$D(^XUSEC(MCESKEY,DUZ)) DIC("B")=DUZ
 D ^DIC K DIC
 Q +Y
STATUS ; Current status of the record
 S Y=$P($G(^MCAR(MCFILE,MCARGDA,0)),U,1) D DD^%DT
 S:MCNODE="" MCREL="Y"
 I MCREL="Y" D
 .S SRELEASE=SRELEASE+1,STATUS=RELEASE,STATUS2="RNV"
 .S ^TMP("MCAR",$J,MCOUNT)=$J(MCARGDA,10,0)_"     "_$J(Y,20)_"     -Released Not Verfied"
 E  D
 .S SDRAFT=SDRAFT+1,STATUS=DRAFT,STATUS2="D"
 .S ^TMP("MCAR",$J,MCOUNT)=$J(MCARGDA,10,0)_"     "_$J(Y,20)_"     -Draft"
 S MCOUNT=MCOUNT+1
 Q
EXIT ;
 K MCAR,MCARDOB,MCARDTM,MCARHDR,MCARRB,MCARWARD,MCRHR,VADM,VAIN
 K MCARP,MCFILE,MCESON,MCESKEY,MCROUT,MCTYPE
 K MCEBRIEF,MCEFULL,MCPBRIEF,MCPFULL,MCPRTRTN,MCBS
 Q
