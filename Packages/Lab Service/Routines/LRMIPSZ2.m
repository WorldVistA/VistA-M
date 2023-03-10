LRMIPSZ2 ;DALOI/STAFF - MICRO PATIENT REPORT - BACTERIA, SIC/SBC, MIC ;Jul 15, 2021@13:13
 ;;5.2;LAB SERVICE;**388,350,427,547**;Sep 27, 1994;Build 10
 ;
 ;
 Q
 ;
ANTI ;
 ; from LRMIPSZ1
 N B,I
 I $O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,14,0)) D
 . W !!,?28,"Antibiotic Level(s):"
 . W !,"ANTIBIOTIC",?20,"CONC RANGE (ug/ml)",?42,"DRAW TIME"
 . S B=0
 . F  S B=$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,14,B)) Q:B<1  D
 . . W !,$P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,14,B,0),U),?20,$P(^(0),U,3),?42,$$EXTERNAL^DILFD(63.42,1,"",$P(^(0),U,2))
 Q
 ;
MES ;LR*5.2*547: Display informational message if accession/test is currently being edited.
 Q:'$G(LR7SB)
 N LR7AREA
 S LR7AREA=$S(LR7SB=1:"Bacteriology",LR7SB=5:"Parasitology",LR7SB=8:"Mycology",LR7SB=11:"Mycobacteriology",1:"Virology")
 Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,LRIDT,LR7SB))
 W !,?22,"**** ATTENTION ****",!,?10,"The "_LR7AREA_" Report is being edited",!,?10,"by tech code ",^XTMP("LRMICRO EDIT",LRDFN,LRIDT,LR7SB)
 W " and current results",!,?10,"may not be visible until approved.",!
 Q
 ;
BACT ;
 ; from LRMIPSZ1
 I $P(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,1),U)="",'$G(LRLABKY) D  Q:'$D(LRWRDVEW)  Q:LRSB'=1
 . Q:'$D(^XTMP("LRMICRO EDIT",LRDFN,LRIDT,1))
 . ;LR*5.2*547: Display informational message if accession/test is currently being edited
 . ;            and results had previously been verified.
 . N LR7SB S LR7SB=1
 . D MES
 D BUG
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,2)) D  Q:LRABORT  ;
 . D NP Q:LRABORT
 . D GRAM
 . D NP
 Q:LRABORT
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,25)) D  Q:LRABORT  ;
 . D NP Q:LRABORT
 . D BSMEAR
 . D NP
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3)) D  Q:LRABORT  ;
 . D NP Q:LRABORT
 . D BRMK Q:LREND
 . D NP Q:LRABORT
 . D BACT^LRMIPSZ5
 . D NP
 ;
 I $D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,4)) D  Q:LRABORT  ;
 . N B,I
 . D NP Q:LRABORT
 . I LRHC W ! D NP Q:LRABORT
 . W !,"Bacteriology Remark(s):"
 . D NP Q:LRABORT
 . S B=0
 . F I=0:0 S B=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,4,B)) Q:B<1  W !,?3,^TMP("LRMI",$J,LRDFN,"MI",LRIDT,4,B,0) D NP Q:LRABORT
 ;
 Q
 ;
 ;
BUG ;
 N LRNS,LRTUS,LRUS,X
 ;
 S X=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,1),LRTUS=$P(X,U,2),DZ=$P(X,U,3),LRUS=$P(X,U,6),LRNS=$P(X,U,5),Y=$P(X,U)
 ;
 D D^LRU
 D NP Q:LRABORT
 W:LRHC !
 D NP Q:LRABORT
 W !,"* BACTERIOLOGY ",$S(LRTUS="F":"FINAL",LRTUS="P":"PRELIMINARY",1:"")," REPORT => "_Y_"   TECH CODE: "_DZ
 D NP Q:LRABORT
 S LRPRE=19
 D PRE^LRMIPSU
 I LRUS'="" D NP Q:LRABORT  W !,"URINE SCREEN: "_$S(LRUS="N":"Negative",LRUS="P":"Positive",1:LRUS) D NP Q:LRABORT  W:LRHC ! D NP Q:LRABORT
 I LRNS'="" D NP Q:LRABORT  W !,"SPUTUM SCREEN:  ",LRNS D NP Q:LRABORT  W:LRHC ! D NP Q:LRABORT
 Q
 ;
 ;
GRAM ;
 N CNT
 ;
 D NP Q:LRABORT
 W !,"GRAM STAIN:"
 S (CNT,LRGRM)=0
 F  S LRGRM=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,2,LRGRM)) Q:LRGRM<1  S CNT=CNT+1 W:CNT>1 ! W ?12,^(LRGRM,0) D NP Q:LRABORT
 I LRHC W !
 D NP
 Q
 ;
 ;
BSMEAR ;
 W !,"BACTERIOLOGY SMEAR/PREP:",!
 S LRMYC=0
 F  S LRMYC=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,25,LRMYC)) Q:LRMYC<1  W ?5,^(LRMYC,0),!
 Q
 ;
 ;
BRMK ;
 ; also called from T51^LRMIV1
 N LRBLDTMP
 S LRBLDTMP=0
 I '$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3)) D  ;
 . S LRBLDTMP=1
 . M ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3)=^LR(LRDFN,"MI",LRIDT,3)
 ;
 S (LRBUG,LR2ORMOR)=0
 F LRAX=1,2 S LRBUG=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG)) Q:LRBUG<1  S:LRAX=2 LR2ORMOR=1
 I LRAX'=1 S (LRBUG,LRTSTS)=0 F LRAX=1:1 S LRBUG=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG)) Q:LRBUG<1  D LST
 ; delete ^TMP if built just for this entrypoint
 I LRBLDTMP K ^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3)
 Q
 ;
 ;
LST ;
 ;
 N LRX
 S LRX=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,0)
 S (LRBUG(LRAX),LRORG)=$P(LRX,U),LRQU=$P(LRX,U,2),LRSSD=$P(LRX,U,3,8),LRORG=$P(^LAB(61.2,LRORG,0),U)
 ;
 I LRSSD'?."^" S LRSIC1=$P(LRSSD,U),LRSBC1=$P(LRSSD,U,2),LRDRTM1=$P(LRSSD,U,3),LRSIC2=$P(LRSSD,U,4),LRSBC2=$P(LRSSD,U,5),LRDRTM2=$P(LRSSD,U,6),LRSSD=1
 D NP Q:LRABORT
 W:LRHC !
 I LRAX=1 W !,"CULTURE RESULTS:"
 E  W !
 W ?17,$S(LR2ORMOR:$J(LRBUG,2)_". ",1:" "),LRORG
 ;
 ; Display quantity/colony count
 I LRQU'="" D
 . S LRX=" - Quantity: "_LRQU
 . I (IOM-$X-1)<$L(LRX) W !,?21
 . W LRX
 ;
 I LRSSD D FH^LRMIPSU Q:LREND  D SSD W:LRHC !
 S:$D(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,2)) LRTSTS=LRTSTS+1
 I $O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,3,0)) D MIC
 D CMNT
 Q
 ;
 ;
SSD ;
 D NP Q:LRABORT
 W !
 ;
 D NP Q:LRABORT
 S LRDRTM1=$S(LRDRTM1="P":"PEAK",LRDRTM1="T":"TROUGH",1:LRDRTM1),LRDRTM2=$S(LRDRTM2="P":"PEAK",LRDRTM2="T":"TROUGH",1:LRDRTM2)
 ;
 I LRSIC1'="" D
 . W !,?20,"SIT " W:LRDRTM1'="" "(",LRDRTM1,")" W ": ",LRSIC1
 . D NP
 Q:LRABORT
 ;
 I LRSBC1'="" D
 . W !,?20,"SBT " W:LRDRTM1'="" "(",LRDRTM1,")" W ": ",LRSBC1
 . D NP
 Q:LRABORT
 ;
 I LRSIC2'="" D
 . W !,?20,"SIT " W:LRDRTM2'="" "(",LRDRTM2,")" W ": ",LRSIC2
 . D NP
 Q:LRABORT
 ;
 I LRSBC2'="" D
 . W !,?20,"SBT " W:LRDRTM2'="" "(",LRDRTM2,")" W ": ",LRSBC2
 . D NP
 ;
 Q
 ;
 ;
MIC ;
 ;
 N B
 W !,?21,"Antibiotic"
 ;
 ; If data in 2/3rd pieces then print header
 S B=0
 F  S B=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,3,B)) Q:B<1  I $P(^(B,0),U,2,3)'="" W ?38,"MIC (ug/ml)",?53,"MBC (ug/ml)" Q
 ;
 ; Print results
 S B=0
 F  S B=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,3,B)) Q:B<1  W !,?21,$P(^(B,0),U),?38,$J($P(^(0),U,2),7),?53,$J($P(^(0),U,3),7)
 Q
 ;
 ;
CMNT ;
 N A,LRX,X,DIWL,DIWR,DIWF,LRIDX
 ;
 S LRPC=0,DIWL=31,DIWR=IOM,DIWF="|"
 F A=0:1 S LRPC=+$O(^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,1,LRPC)) Q:LRPC<1  D  Q:LRABORT
 . S LRX=^TMP("LRMI",$J,LRDFN,"MI",LRIDT,3,LRBUG,1,LRPC,0),X=LRX
 . K ^UTILITY($J,"W")
 . D ^DIWP
 . I A=0,$D(^UTILITY($J,"W",31,1,0)) D
 . . W !,?21,"Comment: "_^UTILITY($J,"W",31,1,0)
 . . K ^UTILITY($J,"W",31,1,0)
 . D NP Q:LRABORT
 . S LRIDX=0
 . F  S LRIDX=$O(^UTILITY($J,"W",31,LRIDX)) Q:'LRIDX  D
 . . Q:'$D(^UTILITY($J,"W",31,LRIDX,0))
 . . W !,?21,"         "_^UTILITY($J,"W",31,LRIDX,0)
 . . D NP
 K ^UTILITY($J,"W")
 Q
 ;
 ;
NP ;
 ; Convenience method
 D NP^LRMIPSZ1
 Q
