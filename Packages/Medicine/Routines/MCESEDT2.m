MCESEDT2 ;WISC/DCB-ELECTRONIC SIGNATURE EDITS PART 2  ;6/26/96  12:51
 ;;2.3;Medicine;;09/13/1996
EDD ; Draft
EDPD ; Problem Draft
 S TEMP=DUZ_U_U_$$NOW(1)_"^^^^"_$$NUMTOES^MCESSCR(LOOP)_"^^^^^^^"
 S:$P($G(^MCAR(MCFILE,REC,"ES")),U,14)="" TEMP=TEMP_"^"_$$NOW(1)
 Q
EDRV ; Release On-line Verify
 D SIGN Q:ERROR=1
 S $P(TEMP,U,4)=DUZ,$P(TEMP,U,6)=$$NOW(1),$P(TEMP,U,8)=$$NOW(1),$P(TEMP,U,9)=$$NOW(1),$P(TEMP,U,2)="",$P(TEMP,U,3)="",$P(TEMP,U,5)=SCRAMBLE
 Q
EDROV ; Release Off-Line Verify
 D SIGN Q:ERROR=1
 S DIR(0)="E",DIR("T")=30 D ^DIR K DIR,DIRUT,DTOUT,DIROUT
 I $D(DUOUT) S TEMP=ORG,EXIT=1 K DUOUT Q
 D HEADER^MCESEDT
 W !!,IOBON,"Please enter a provider that you are signing for",IOBOFF
 W !,"Note: This provider must have a key for ",IOUON,MCROUT,IOUOFF,!
 S DIC=200,DIC(0)="AEQMZ"
 S DIC("A")="Please select a Provider with a "_IOINHI_MCROUT_IOINORM_" key: "
 S DIC("S")="I $D(^XUSEC(MCESKEY,Y)),(Y'=DUZ)" D ^DIC K DIC
 S CDUZ=+Y
 I $D(DUOUT)!($D(DTOUT))!(CDUZ<0) S EXIT=1,TEMP=ORG D:$G(SUP)="S" DELSS^MCESEDT Q
 S $P(TEMP,U,1)=DUZ,$P(TEMP,U,3)=$$NOW(1),$P(TEMP,U,8)=$$NOW(1),$P(TEMP,U,9)=$$NOW(1),$P(TEMP,U,4)=CDUZ,$P(TEMP,U,2)=SCRAMBLE
 Q
SIGN ; Display message, checks for elect. sign
 I $P($G(^VA(200,DUZ,20)),U,4)="" D ERROR S ERROR=1 Q
 W !!,"In order to "_IOUON_"release and verify"_IOUOFF_" procedure results",!,"you must type in your electronic signature code."
 D SIG^XUSESIG S:X1="" ERROR=1
 I ERROR=1 D HEADER^MCESEDT,ERROR Q
 S SCRAMBLE=$$ENCODE^MCESPRT(MCFILE,MCARGDA)
 Q
EDRNV ; Release Not Verify
 I NCHANGE G EDRNV1
 W !!,IOINHI,IOBON,*7,"This option should be used with extreme CAUTION.",IOINORM,IOBOFF
 W !,"You can be held accountable for releasing unverified procedure results",!!
 S DIR(0)="Y",DIR("B")="N",DIR("A")="Do you "_IOUON_"still"_IOUOFF_" want to countinue" D ^DIR K DIR
 I Y=0!$D(DIRUT) S EXIT=1 Q
EDRNV1 ;
 W !!
 S DIR("B")="NO",DIR(0)="Y"
 S DIR("A",1)="Since this record is "_IOUON_"Released Not Verified"_IOUOFF
 S DIR("A")="Do you want to mark this record for deletion"
 S DIR("?",1)="When you "_IOUON_"mark a record for deletion"_IOUOFF_","
 S DIR("?",2)="the record will be gone from your view and everyone else's"
 S DIR("?",3)="view with the exception of the manager of "_IOUON_MCROUT_IOUOFF_"."
 S DIR("?")="YES: Mark it for deletion  NO: Don't mark it for deletion"
 D ^DIR K DIR I $D(DIRUT) S EXIT=1 Q
 I Y=1 S $P(TEMP,U,12)="1",$P(TEMP,U,13)=DUZ,$P(TEMP,U,3)=$$NOW(1)
 I NCHANGE=0 S $P(TEMP,U,8)=$$NOW(1),$P(TEMP,U,9)="",$P(TEMP,U,1)=DUZ,$P(TEMP,U,3)=$$NOW(1)
 Q
EDS ; Superseded
 S MCESTEMP=ORG
 W !!!,"You must sign a Superseded record in order to complete the process"
 S DIR(0)="Y",DIR("B")="NO",DIR("A")="Do you "_IOUON_"still"_IOUOFF_" want to countinue" D ^DIR K DIR
 I Y=0!(Y=U)!(Y="") S EXIT=1 K MCBACK Q
 S (X,MX)=$P(^MCAR(MCFILE,REC,0),U,1)
 S NOW=$$NOW(X)
 S PDATE=+$P(TEMP,U,15)
 W !!,?14,IOBON,IODWL,IOUON,"Please Wait!",IOBOFF,IOUOFF
 K DD,DO,DIC S HOLD="^MCAR("_MCFILE_",",DIC=HOLD,X=$P(^MCAR(MCFILE,REC,0),U,1),DIC(0)=""
 D FILE^DICN S NEWREC=+Y
 I +Y=-1 W !!,IOINHI,"An ",IOBON,"error",IOBOFF," has occured",!,"in creating the new record" S EXIT=1 Q
 W !!,"Record "_REC_" copy to "_NEWREC_"."
 S %X=HOLD_REC_",",%Y=HOLD_NEWREC_"," D %XY^%RCR
 S ^MCAR(MCFILE,NEWREC,"ES")=DUZ_U_U_NOW_U_U_U_U_"D"_U_U_U_REC_U_U_U_U_PDATE_U_NOW
 W !,"Indexing "_NEWREC_"." S DIK=HOLD,DA=NEWREC D IX^DIK K DIK
 S $P(TEMP,U,11)=NEWREC,$P(TEMP,U,3)=NOW
 S $P(TEMP,U,1)=DUZ,$P(TEMP,U,3)=NOW,$P(TEMP,U,8)=NOW,$P(TEMP,U,9)=NOW
 W !!,"Your Procedure has been Copied",!,"You can now make changes to the copy."
 W !,"New Record:",!
 S DIC="^MCAR("_MCFILE_",",DIC(0)="EMQZ",X=" " D ^DIC K DIC
 S MCY=Y,MCY(0)=Y(0),MCY(0,0)=Y(0,0)
 S MCESPREV=REC,MCESCUR=NEWREC,MCBACK=1
 S $P(^MCAR(MCFILE,NEWREC,"ES"),U,16)=+$P(TEMP,U,16)+1
 K PDATE,NOW,TY,X,DTOUT,DUOUT,DIROUT
 Q
EDSRV ; NO
EDSROV ; OP
 Q
ERROR ;
 K NEWST ;D HEADER^MCESEDT
 W !!,IOINHI,IOBON,*7,"Your electronic signature is invalid or not declared.",IOINORM,IOBOFF
 W !!,"You must declare an electronic signature or ask your IRM for help."
 W !,"===> No changes to release status can be done. <===="
 S TEMP=ORG,ERROR=1,EXIT=1
 Q
ASK ;
 S DIR("A")=IOINHI_"Please Select a New Status"_IOINORM
 D ^DIR I $D(DIRUT) S EXIT=1
 I Y=DIR("B"),(PROV>2) S EXIT=1
 K DIR Q:EXIT=1
 S NEWST=Y(0) D HEADER^MCESEDT Q
NOW(TA) ;
 D NOW^%DTC Q $E(%,1,12)
 Q
