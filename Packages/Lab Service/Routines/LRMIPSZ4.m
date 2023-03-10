LRMIPSZ4 ;DALOI/RBN - MICRO PATIENT REPORT - AFB, FUNGUS ;Jul 15, 2021@13:13
 ;;5.2;LAB SERVICE;**350,547**;Sep 27, 1994;Build 10
 ;
 ;Reference to ^DD supported by ICR #999
 ;
 Q
 ;
TB ;
 ; from LRMIPSZ1
 ; also called from RPT^LROR4
 N B,LRBLDTMP,LRQUIT,LRTA,LRX
 S (LRBLDTMP,LRQUIT)=0
 I '$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT)) D  ;
 . S LRBLDTMP=1
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)=^LR(LRDFN,"MI",LRIDT)
 . K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,32)
 ;
 I $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,11),U)="",'$G(LRLABKY) D  S:'$D(LRWRDVEW) LRQUIT=1 S:LRSB'=11 LRQUIT=1
 . Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,LRIDT,11))
 . ;LR*5.2*547: Display informational message if accession/test is currently being edited
 . ;            and results had previously been verified.
 . N LR7SB S LR7SB=11
 . D MES^LRMIPSZ2
 ;
 I LRQUIT D  Q
 . I LRBLDTMP K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)
 ;
 S LRX=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,11)
 S LRTUS=$P(LRX,U,2),DZ=$P(LRX,U,5),LRAFS=$P(LRX,U,3),LRAMT=$P(LRX,U,4),Y=$P(LRX,U)
 D D^LRU
 W:LRHC !
 W !,"* MYCOBACTERIOLOGY ",$S(LRTUS="F":"FINAL",LRTUS="P":"PRELIMINARY",1:"")," REPORT => "_Y_"   TECH CODE: "_DZ
 S LRPRE=23
 D PRE^LRMIPSU
 ;
 S LRTA=""
 I $O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,0)) S LRTA=0
 D:LRAFS'=""!(LRTA=0) AFS
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,13)) D  ;
 . W:LRHC !
 . W !,"Mycobacteriology Remark(s):"
 . D NP Q:LRABORT
 . S B=0
 . F  S B=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,13,B)) Q:B<1  W !,?3,^(B,0) D NP Q:LRABORT
 ;
 I LRBLDTMP K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)
 Q
 ;
 ;
AFS ; Acid Fast Stain results
 ;
 N LRX,X
 ;
 I LRAFS'="" D
 . S LRX="Acid Fast Stain:  "
 . I LRAFS?1(1"DP",1"DN",1"CP",1"CN") D
 . . S LRX=$S($E(LRAFS)="D":"Direct ",$E(LRAFS)="C":"Concentrate ",1:"")_LRX
 . . S LRX=LRX_$S($E(LRAFS,2)="P":"Positive",$E(LRAFS,2)="N":"Negative",1:LRAFS)
 . E  D
 . . S X=$$GET1^DIQ(63.05,LRIDT_","_LRDFN_",",24)
 . . I X'="" S LRX=LRX_X Q
 . . S LRX=LRX_LRAFS
 . W:LRHC ! W !,LRX
 . I LRAMT'="" W !,?3,"Quantity: ",LRAMT
 ;
 K ^TMP("LR",$J,"T"),LRTSTS
 ;
 I LRTA=0 D
 . S LRTSTS=0
 . F  S LRTA=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,LRTA)) Q:LRTA<1  D
 . . S (LRBUG(LRTA),LRTBC)=$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,LRTA,0),U)
 . . S LRQU=$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,LRTA,0),U,2)
 . . S LRTBC=$P(^LAB(61.2,LRTBC,0),U)
 . . D LIST
 ;
 Q
 ;
 ;
LIST ; List organisms
 ;
 N B,LRTB,LRTBA,LRTBS,LRX
 W:LRHC !
 D NP Q:LRABORT
 W !,"Mycobacterium: ",LRTBC
 D NP Q:LRABORT
 I LRQU'="" W !,?3,"Quantity: ",LRQU D NP Q:LRABORT
 S:$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,LRTA,2)) LRTSTS=LRTSTS+1
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,LRTA)) D  Q:LRABORT  ;
 . W !,"   Comment: "
 . D NP Q:LRABORT
 . S B=0
 . F  S B=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,LRTA,1,B)) Q:B<1  W ?13,^(B,0),! D NP Q:LRABORT
 ;
 ;
SEN ; Display AFB sensitivities.
 ;
 S LRTB=2
 F  S LRTB=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,LRTA,LRTB)) Q:LRTB'["2."!(LRTB="")  D  ;
 . S LRTBS=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,12,LRTA,LRTB)
 . I LRTBS="" Q
 . S LRTBA=""
 . I $D(^LAB(62.06,"AD1",LRTB)) D
 . . S LRX=$O(^LAB(62.06,"AD1",LRTB,0)),LRX(0)=""
 . . I LRX S LRX(0)=$G(^LAB(62.06,LRX,0))
 . . S LRTBA=$P(LRX(0),"^")
 . I LRTBA="" D
 . . S LRTBA=$O(^DD(63.39,"GL",LRTB,1,0))
 . . S LRTBA=$P(^DD(63.39,LRTBA,0),U)
 . W !,?3,$$LJ^XLFSTR(LRTBA,30,"."),?34,LRTBS
 Q
 ;
 ;
FUNG ;
 ; from LRMIPSZ1
 ; also called from RPT^LROR4
 N LRBLDTMP,LRQUIT
 S (LRBLDTMP,LRQUIT)=0
 I '$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT)) D  ;
 . S LRBLDTMP=1
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)=^LR(LRDFN,"MI",LRIDT)
 . K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,32)
 ;
 I $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,8),U)="",'$G(LRLABKY) D  S:'$D(LRWRDVEW) LRQUIT=1 S:LRSB'=8 LRQUIT=1
 . Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,LRIDT,8))
 . ;LR*5.2*547: Display informational message if accession/test is currently being edited
 . ;            and results had previously been verified.
 . N LR7SB S LR7SB=8
 . D MES^LRMIPSZ2
 ;
 I LRQUIT D  Q
 . I LRBLDTMP K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)
 ;
 S LRTUS=$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,8),U,2)
 S DZ=$P(^(8),U,3),Y=$P(^(8),U)
 D D^LRU
 W:LRHC !
 D NP Q:LRABORT
 W !,"* MYCOLOGY ",$S(LRTUS="F":"FINAL",LRTUS="P":"PRELIMINARY",1:"")," REPORT => ",Y,"   TECH CODE: ",DZ
 D NP Q:LRABORT
 S LRPRE=22 D PRE^LRMIPSU
 D QA
 ;
 I LRBLDTMP K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT)
 Q
 ;
 ;
QA ;
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,15)) D  ;
 . W:LRHC !
 . D NP Q:LRABORT
 . W !,"MYCOLOGY SMEAR/PREP:"
 . S LRMYC=0
 . F  S LRMYC=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,15,LRMYC)) Q:LRMYC<1  W !?5,^(LRMYC,0) D NP Q:LRABORT
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,9)) D  ;
 . W:LRHC !
 . D NP Q:LRABORT
 . W !,"Fungus/Yeast: "
 . D NP Q:LRABORT
 . D SHOW
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,10)) D  ;
 . W:LRHC !
 . D NP Q:LRABORT
 . W !,"Mycology Remark(s):"
 . D NP Q:LRABORT
 . S LRMYC=0
 . F  S LRMYC=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,10,LRMYC)) Q:LRMYC<1  W !,?3,^(LRMYC,0) D NP Q:LRABORT
 ;
 Q
 ;
 ;
SHOW ;
 ;
 S LRTA=0
 F  S LRTA=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,9,LRTA)) Q:LRTA?.N2A.E!(LRTA<1)  D
 . S LRTA=+LRTA
 . S (LRBUG(LRTA),LRTBC)=$P(^(LRTA,0),U)
 . S LRQU=$P(^(0),U,2)
 . S LRTBC=$P(^LAB(61.2,LRTBC,0),U)
 . D LIST1
 ;
 Q
 ;
 ;
LIST1 ;
 ;
 N B
 W !,LRTBC
 D NP Q:LRABORT
 I LRQU'="" W !,?3,"Quantity: ",LRQU
 D NP Q:LRABORT
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,9,LRTA,1,0)) D  ;
 . W !,?3,"Comment:"
 . S B=0
 . F  S B=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,9,LRTA,1,B)) Q:B<1  W ?13,^(B,0),! D NP Q:LRABORT
 Q
 ;
 ;
NP ;
 ; Convenience method
 D NP^LRMIPSZ1
 Q
