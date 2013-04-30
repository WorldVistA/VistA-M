LR7OSUM4 ;DALOI/STAFF - Silent Patient cum cont. ;06/04/12  11:15
 ;;5.2;LAB SERVICE;**121,187,228,241,251,350**;Sep 27, 1994;Build 230
 ;
BS ;from LR7OSUM3
 ;
 K I,Z,^TMP($J,"TY")
 ;
 S LRCW=10,LRHI="",LRLO="",LRTT=1,I=0,LRTY=GIOM-28\10,LRMU=LRMU+1,LRII=0
 ;
 F  S LRII=$O(^LAB(64.5,1,1,LRMH,1,LRSH,1,LRII)) Q:LRII<1  D
 . S Z=^LAB(64.5,1,1,LRMH,1,LRSH,1,LRII,0),P3=$P(Z,U,3),P6=$P(Z,U,6),I=I+1,I(I)=LRII
 . S ^TMP($J,"TY",0,I)=P3 S:P6 ^TMP($J,"TY",I,"D")=P6
 K P3,P6
 ;
 F K=1:1:(LRTY-1) S LRFDT=$O(^TMP($J,LRDFN,LRMH,LRSH,LRFDT)) Q:LRFDT<1  D
 . S Z=^TMP($J,LRDFN,LRMH,LRSH,LRFDT,0),^TMP($J,"TY",K,"L")=$P(Z,U,1),LRTT=LRTT+1
 . D BS1
 . S:LRFDT>LRLFDT LRLFDT=LRFDT
 ;
 S:LRTT>(LRTY-1)&(LRMULT=1) LRFULL=1
 S:LRTT>(LRTY-1)&(LRMU=(LRMULT-1)) LRFULL=1
 F I=1:1:LRSHD D LRLO^LR7OSUM5 S:LRLOHI'="" ^TMP($J,"TY",(LRTT+1),I)=LRLOHI S:P7'="" ^TMP($J,"TY",LRTT,I)=P7
 S ^TMP($J,"TY",LRTT,"T")="Units",^TMP($J,"TY",(LRTT+1),"T")="Ranges"
 S ^TMP($J,"TY",(LRTT+1),0)=$S($P(^LAB(64.5,"A",1,LRMH,LRSH,I(1)),U,11)'="":"Therapeutic",1:"Reference")
 S ^TMP($J,"TY",LRTT,0)=""
 ;
 D LINE,LN
 S ^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(CCNT,CCNT,$E(LRTOPP,1,15))_$$S^LR7OS(16,CCNT,"")
 F I=1:1:(LRTT+1) S ^TMP("LRC",$J,GCNT,0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(I*10-4,CCNT,$J(^TMP($J,"TY",I,0),10))
 ;
 D LN
 S XZ="",$P(XZ," ",3)="",^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(CCNT,CCNT,XZ)_$$S^LR7OS(16,CCNT,"")
 F I=1:1:(LRTT-1) S ^TMP("LRC",$J,GCNT,0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(I*10-4,CCNT,$J(^TMP($J,"Y2K",I),10))
 ;
 D LN
 S XZ="",$P(XZ," ",3)="",^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(CCNT,CCNT,XZ)_$$S^LR7OS(16,CCNT,"")
 F I=1:1:(LRTT+1) S ^TMP("LRC",$J,GCNT,0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(I*10-4,CCNT,$J(^TMP($J,"TY",I,"T"),10))
 ;
 D LN
 S XZ="-",$P(XZ,"-",GIOM)="",^TMP("LRC",$J,GCNT,0)=XZ
 F I=1:1:LRSHD D
 . S LRCL=16,LRG=^LAB(64.5,1,1,LRMH,1,LRSH,1,I(I),0)
 . D LN S ^TMP("LRC",$J,GCNT,0)=""
 . D BS4
 I $D(LRTX) D
 . D LN S LRTX="",^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,"Comments: ")_$$S^LR7OS(16,CCNT,"")
 . F I=1:1 S LRTX=$O(LRTX(LRTX)) Q:LRTX=""  D
 . . S ^TMP("LRC",$J,GCNT,0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(10*LRTX+2,CCNT,$P(^TMP("LRCMTINDX",$J,$P(LRTX(LRTX),"^")),"^"))
 ;
 D TXT1^LR7OSUM5
 S LROFDT=LRFDT
 I $D(LRTX) D
 . S LRTX=""
 . F I=1:1 S LRTX=$O(LRTX(LRTX)) Q:LRTX=""  D
 . . D LN
 . . S LRFDT=LRTX(LRTX),^TMP("LRC",$J,GCNT,0)=$$S^LR7OS(1,CCNT,$P(^TMP("LRCMTINDX",$J,LRFDT),"^")_". ")
 . . D TXT^LR7OSUM5
 S LRFDT=LROFDT
 K LRTY,LRTX,^TMP($J,"TY")
 I 'LRFDT G LRSH^LR7OSUM3
 I $O(^TMP($J,LRDFN,LRMH,LRSH,LRFDT))="" G LRSH^LR7OSUM3
 S LRFDT=LRLFDT
 I LRFULL D HEAD^LR7OSUM6,LRNP^LR7OSUM3 S LRFULL=0,LRMU=0
 G BS
 ;
 ;
BS1 ;
 N LRDATE
 S LRDATE=$$FMTE^XLFDT(9999999-LRFDT,"1"_$S(+$P(Z,"^",6):"D",1:"M"))
 S ^TMP($J,"TY",K,0)=$P(LRDATE,",",1)
 S ^TMP($J,"TY",K,"T")=$P(LRDATE,"@",2)
 S ^TMP($J,"Y2K",K)=$P($P(LRDATE," ",3),"@")
 F J=1:1:LRSHD D
 . S:$D(^TMP($J,LRDFN,LRMH,LRSH,LRFDT,I(J))) ^TMP($J,"TY",K,J)=^(I(J))
 . S:$D(^TMP($J,LRDFN,LRMH,LRSH,LRFDT,"TX"))&'$D(LRTX(LRTT)) LRTX(LRTT)=LRFDT
 Q
 ;
 ;
BS2 ;
 S X=$S($D(^TMP($J,"TY",J,I)):$P(^(I),U,1),1:"")
 S X1=$S(X'="":$P(^TMP($J,"TY",J,I),U,2),1:"")
 S LRDP=$S($D(^TMP($J,"TY",I,"D")):^("D"),1:""),LRCL=LRCL+10
 K T1,T3
 Q
 ;
 ;
BS4 ;
 ;
 ; Build test names on left column
 N LROVRFL
 S LROVRFL=""
 S X=^TMP($J,"TY",0,I)
 I $L(X)>15 S LROVRFL=$E(X,16,100)
 S ^TMP("LRC",$J,GCNT,0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(1,CCNT,$E(X,1,15))_$$S^LR7OS(16,CCNT,"")
 S:'$P($G(^TMP("LRT",$J,X)),"^",2) $P(^TMP("LRT",$J,X),"^",2)=GCNT
 ;
 ; Print test results then unit/reference ranges
 F J=1:1:(LRTT+1) D
 . D BS2
 . I X="" Q
 . I J'<LRTT N LRDP S LRDP=""
 . D C1^LR7OSUM5(.X,.X1)
 . I $P(LRG,U,4)'=""&(J<LRTT) S @("X="_$P(LRG,"^",4)),^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(J*10+8,CCNT,X_X1)
 . I $P(LRG,U,4)=""!(J'<LRTT) S ^(0)=^TMP("LRC",$J,GCNT,0)_$$S^LR7OS(J*10+8,CCNT,$J(X,LRCW))
 ;
 ; Handle overflow on test name, indent 1 character for readability
 I LROVRFL'="" F  S X=$E(LROVRFL,1,14),LROVRFL=$E(LROVRFL,15,100) Q:X=""  S GCNT=GCNT+1,^TMP("LRC",$J,GCNT,0)=" "_X
 ;
 Q
 ;
 ;
LN ; Increment the counter
 S GCNT=GCNT+1,CCNT=1
 Q
 ;
 ;
LINE ; Fill in the global with bank lines
 N X
 D LN
 S X=" ",$P(X," ",GIOM)="",^TMP("LRC",$J,GCNT,0)=X
 Q
