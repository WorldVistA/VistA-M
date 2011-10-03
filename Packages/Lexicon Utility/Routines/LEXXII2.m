LEXXII2 ;ISL/KER - Lexicon Status (Data Status) ;07/16/2008
 ;;2.0;LEXICON UTILITY;**59**;Sep 23, 1996;Build 6
 ;
 ; Variables NEWed or KILLed Elsewhere
 ;   LEXSUB  NEWed by LEXXII and LEXXFI sending message
 ;   
 ; Global Variables
 ;    ^LEXM(              N/A
 ;    ^TMP("LEXVER",$J)   SACC 2.3.2.5.1
 ;               
 ; External References
 ;    ^DIM                ICR  10016
 ;               
 Q
RESULTS(X) ; Get Results of Install
 D SETUP^LEXXII2 N LEXR S LEXR=$$CHK S X="" S:$L($P(LEXR,"^",2)) X=$P(LEXR,"^",2) K ^TMP("LEXVER",$J)
 Q X
SETUP ; Last Set/Kills (Negation)
 Q:'$D(^LEXM)  Q:+($O(^LEXM(0)))'>0  K ^TMP("LEXVER",$J) N LEXC1,LEXC2,LEXCK,LEXCS,LEXCT,LEXEC,LEXFI,LEXIEN,LEXKK,LEXLK,LEXLS,LEXOK,LEXSAB,LEXSK,LEXSS,LEXT,LEXTT,X
 S LEXFI=9999.999 F  S LEXFI=$O(^LEXM(LEXFI),-1) Q:+LEXFI=0  D LLF(LEXFI)
 S LEXFI=0 F  S LEXFI=$O(^LEXM(LEXFI)) Q:+LEXFI'>0  D FIR(LEXFI) Q:$L($G(LEXSK("FIR","SK")))
 D VERC
 Q
LLF(X) ;   Last Set/Last Kill for File X
 N LEXFI,LEXIEN,LEXLK,LEXLS,LEXSAB S LEXFI=$G(X),(LEXLS,LEXLK)="" Q:$O(^LEXM(LEXFI,0))'>0
 S LEXSAB=$S(+($G(LEXFI))=80:"ICD",+($G(LEXFI))=80.1:"ICP",+($G(LEXFI))=81:"CPT",+($G(LEXFI))=81.3:"CPM",$E(+($G(LEXFI)),1,3)="757"&($E(+($G(LEXFI)),1,5)'="757.9"):"LEX",1:"")
 Q:'$L(LEXSAB)  Q:$L($G(LEXSK(LEXSAB,"LS")))&($L($G(LEXSK(LEXSAB,"LK"))))  S LEXIEN=+($O(^LEXM(LEXFI," "),-1))+1
 F  S LEXIEN=$O(^LEXM(LEXFI,LEXIEN),-1) Q:+LEXIEN=0  D  Q:$L(LEXLS)&($L(LEXLK))
 . Q:$G(^LEXM(LEXFI,LEXIEN))["^DD("  Q:+LEXIEN=0
 . I $E($G(^LEXM(LEXFI,LEXIEN)),1,3)="S ^",'$L(LEXLS),'$L($G(LEXSK(LEXSAB,"LS"))) D
 . . S LEXLS=$G(^LEXM(LEXFI,LEXIEN)) S:'$D(LEXSK(LEXSAB,"LS")) LEXSK(LEXSAB,"LS")=$G(^LEXM(LEXFI,LEXIEN))
 . I $E($G(^LEXM(LEXFI,LEXIEN)),1,3)="K ^",'$L(LEXLK),'$L($G(LEXSK(LEXSAB,"LK"))) D
 . . S LEXLK=$G(^LEXM(LEXFI,LEXIEN)) S:'$D(LEXSK(LEXSAB,"LK")) LEXSK(LEXSAB,"LK")=$G(^LEXM(LEXFI,LEXIEN))
 Q
FIR(X) ;   First Set/Kill
 N LEXFI,LEXIEN,LEXLK,LEXLS,LEXSAB S LEXFI=$G(X),(LEXLS,LEXLK)="" Q:$O(^LEXM(LEXFI,0))'>0  S LEXSAB="FIR"
 Q:$L($G(LEXSK(LEXSAB,"SK")))  S LEXIEN=0 F  S LEXIEN=$O(^LEXM(LEXFI,LEXIEN)) Q:+LEXIEN'>0  D  Q:$L($G(LEXSK(LEXSAB,"SK")))
 . Q:$L($G(LEXSK(LEXSAB,"SK")))  Q:$G(^LEXM(LEXFI,LEXIEN))["^DD("
 . I $E($G(^LEXM(LEXFI,LEXIEN)),1,3)="S ^" S:'$D(LEXSK(LEXSAB,"SK")) LEXSK(LEXSAB,"SK")=$G(^LEXM(LEXFI,LEXIEN)) Q
 . I $E($G(^LEXM(LEXFI,LEXIEN)),1,3)="K ^" S:'$D(LEXSK(LEXSAB,"SK")) LEXSK(LEXSAB,"SK")=$G(^LEXM(LEXFI,LEXIEN)) Q
 Q
VERC ;   Verification Check for file
 N LEXCK,LEXCS,LEXCT,LEXKK,LEXSS,LEXTT,LEXSAB
 N LEXSAB F LEXSAB="LEX","ICD","CPT","CPM","FIR" D
 . S (LEXCS,LEXCK,LEXCT)="" S LEXSS=$G(LEXSK(LEXSAB,"LS")),LEXCS=$P(LEXSS,"=",1),LEXCS=$P(LEXCS," ",2,299)
 . S LEXKK=$G(LEXSK(LEXSAB,"LK")),LEXCK=$P(LEXKK,"=",1),LEXCK=$P(LEXCK," ",2,299)
 . S LEXTT=$G(LEXSK(LEXSAB,"SK")),LEXCT=$P(LEXTT,"=",1),LEXCT=$P(LEXCT," ",2,299)
 . D:$L(LEXCS)!($L(LEXCK))!($L(LEXCT)) VERS
 Q
VERS ;   Verification Strings
 Q:'$L(LEXSAB)  I $G(LEXSAB)="FIR" D  Q
 . Q:'$L($G(LEXTT))  Q:'$L($G(LEXCT))  S (LEXC1,LEXC2)=""  I $E(LEXTT,1,3)="S ^",LEXTT[LEXCT D
 . . S LEXC1="S:"_"$D("_LEXCT_")"_" LEXOK(""FIR"",1)=1" S X=LEXC1 D ^DIM S:'$D(X) LEXC1=""
 . . S LEXC2="S:"_"'$D("_LEXCT_")"_" LEXOK(""FIR"",1)=0" S X=LEXC2 D ^DIM S:'$D(X) LEXC2=""
 . I $E(LEXTT,1,3)="K ^",LEXTT[LEXCT D
 . . S LEXC1="S:"_"'$D("_LEXCT_")"_" LEXOK(""FIR"",1)=1" S X=LEXC1 D ^DIM S:'$D(X) LEXC1=""
 . . S LEXC2="S:"_"$D("_LEXCT_")"_" LEXOK(""FIR"")1)=0" S X=LEXC2 D ^DIM S:'$D(X) LEXC2=""
 . S:$L(LEXSAB)&($L(LEXC1)) ^TMP("LEXVER",$J,LEXSAB,1)=LEXC1 S:$L(LEXSAB)&($L(LEXC2)) ^TMP("LEXVER",$J,LEXSAB,2)=LEXC2
 N LEXC1,LEXC2 S (LEXC1,LEXC2)=""  S:$L(LEXCS) LEXC1="$D("_LEXCS_")" S:$L(LEXCK) LEXC2="'$D("_LEXCK_")" Q:'$L(LEXC1)&('$L(LEXC2))
 I $L(LEXCS)&($L(LEXCK)) D
 . S LEXC1="S:"_"$D("_LEXCS_")"_"&("_"'$D("_LEXCK_")"_") LEXOK("""_LEXSAB_""",2)=1" S X=LEXC1 D ^DIM S:'$D(X) LEXC1=""
 . S LEXC2="S:"_"'$D("_LEXCS_")"_"!("_"$D("_LEXCK_")"_") LEXOK("""_LEXSAB_""",3)=0" S X=LEXC2 D ^DIM S:'$D(X) LEXC2=""
 I $L(LEXCS)&('$L(LEXCK)) D
 . S LEXC1="S:"_"$D("_LEXCS_")"_" LEXOK("""_LEXSAB_""",2)=1" S X=LEXC1 D ^DIM S:'$D(X) LEXC1=""
 . S LEXC2="S:"_"'$D("_LEXCS_")"_" LEXOK("""_LEXSAB_""",3)=0" S X=LEXC2 D ^DIM S:'$D(X) LEXC2=""
 I '$L(LEXCS)&($L(LEXCK)) D
 . S LEXC1="S:"_"'$D("_LEXCK_")"_" LEXOK("""_LEXSAB_""",2)=1" S X=LEXC1 D ^DIM S:'$D(X) LEXC1=""
 . S LEXC2="S:"_"$D("_LEXCK_")"_" LEXOK("""_LEXSAB_""",3)=0" S X=LEXC2 D ^DIM S:'$D(X) LEXC2=""
 S:$L(LEXSAB)&($L(LEXC1)) ^TMP("LEXVER",$J,LEXSAB,1)=LEXC1 S:$L(LEXSAB)&($L(LEXC2)) ^TMP("LEXVER",$J,LEXSAB,2)=LEXC2
 Q
 ;                 
CHECK ; Check if Data is installed
 N LEXC,LEXEC,LEXFN,LEXOK,LEXSAB,LEXST,LEXT,X S LEXC=$$CHK K ^TMP("LEXVER",$J) Q:'$L($P(LEXC,"^",2))
 S LEXT="  Data:        "_$P(LEXC,"^",2) D TL(LEXT)
 Q
CHK(X) ;   Check if Data is Fully Installed
 Q:'$D(^TMP("LEXVER",$J)) ""  N LEXEC,LEXFN,LEXOK,LEXSAB,LEXST,LEXT S LEXST=0,LEXFN=1,LEXOK("FIR",1)=0 F LEXSAB="LEX","ICD","CPT","CPM" D
 . Q:'$D(^TMP("LEXVER",$J,LEXSAB))  S LEXOK(LEXSAB,2)=0,LEXOK(LEXSAB,3)=1
 F LEXSAB="FIR","LEX","ICD","CPT","CPM" D
 . Q:'$D(^TMP("LEXVER",$J,LEXSAB))  S (LEXEC,X)=$G(^TMP("LEXVER",$J,LEXSAB,1)) D ^DIM X:$D(X) LEXEC
 . S (LEXEC,X)=$G(^TMP("LEXVER",$J,LEXSAB,2)) D ^DIM X:$D(X) LEXEC
 . Q:LEXSAB="FIR"  S:+($G(LEXOK(LEXSAB,2)))'>0 LEXFN=0
 S:+($G(LEXOK("FIR",1)))>0 LEXST=1
 S:+($G(LEXST))>0&(+($G(LEXFN))>0) X="1^Installation of data completed successfully"
 S:+($G(LEXST))>0&(+($G(LEXFN))'>0) X="0^Installation of data started but did not finish (incomplete)"
 S:+($G(LEXST))'>0 X="0^Installation of data not started (incomplete)"
 S:'$D(^TMP("LEXVER",$J)) X=0
 Q X
 ;                 
 ; Miscellaneous
BL ;   Blank Line
 D TL("") Q
TL(X) ;   Text Line
 W !,$G(X) Q
 S LEXSUB=$G(LEXSUB) S:'$L(LEXSUB) LEXSUB="LEXXII"
 I '$D(^TMP(LEXSUB,$J,1)) S ^TMP(LEXSUB,$J,1)=" ",^TMP(LEXSUB,$J,0)=1
 N LEXNX S LEXNX=$O(^TMP(LEXSUB,$J," "),-1),LEXNX=LEXNX+1
 S ^TMP(LEXSUB,$J,LEXNX)=" "_$G(X),^TMP(LEXSUB,$J,0)=LEXNX
 Q
