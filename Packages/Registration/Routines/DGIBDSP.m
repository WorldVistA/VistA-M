DGIBDSP ;ALB/SCK - FORMATTED INSURANCE DISPLAY ; 16-JUNE-04
 ;;5.3;Registration;**570,670**;Aug 13, 1993
 ; This routine replaces the supported API DISP^IBCNS which provided a formatted
 ; display of patient insurance information.  This functionality was removed
 ; when DBIA10146 was retired.
 ;
 Q
 ;
DISP ;-Display all insurance company information
 ;  -input DFN
 ;  -input DGSTAT [optional] Defaults to "RAB" if not defined.
 ;
 N DGDTIN
 Q:'$D(DFN)  D:'$D(IOF) HOME^%ZIS
 ;
 N X,DGINS,DGX,DGRTN,DGERR,DGY
 ;
 I '$D(DGSTAT) S DGSTAT="RAB"
 S DGX=$$INSUR^IBBAPI(DFN,"",DGSTAT,.DGRTN,"*")
 S:DGX<0 DGERR=$O(DGRTN("IBBAPI","INSUR","ERROR",0))
 ;
 D HDR
 I $G(DGERR) W !?6,DGRTN("IBBAPI","INSUR","ERROR",DGERR) G DISPQ
 I 'DGX W !,"    No Insurance Information" G DISPQ
 ;
 M DGINS=DGRTN("IBBAPI","INSUR")
 S DGY=0
 F  S DGY=$O(DGINS(DGY)) Q:'DGY  D D1(DGY)
 ;
DISPQ W ! I $D(DGRTN("BUFFER")) D
 . I DGRTN("BUFFER")>0 W !?17,"*** Patient has Insurance Buffer entries ***"
 K DGSTAT
 Q
 ;
HDR ; -- print standard header
 D HDR1("=",IOM-$S($G(DGDTIN):1,1:4))
 Q
 ;
HDR1(CHAR,LENG) ; -- print header, specify character
 N OFF
 S OFF=$S($G(DGDTIN):0,1:2)
 W !?(1+OFF),"Insurance",?(13+OFF),"COB",?(17+OFF),"Subscriber ID",?(35+OFF),"Group",?(47+OFF),"Holder",?(55+OFF),"Effect"_$S('OFF:"",1:"i")_"ve",?(65+OFF+$S('OFF:0,1:1)),"Expires" W:'OFF ?75,"Only"
 I $G(CHAR)'="",LENG S X="",$P(X,CHAR,LENG)="" W !?(1+OFF),X
 Q
 ;
D1(DGVAL) ; 
 N DGX,DGY,DGZ,CAT,OFF
 ;
 Q:'$D(DGINS)
 S OFF=$S($G(DGDTIN):0,1:2)
 W !?(1+OFF),$S($D(DGINS(DGVAL,1)):$E($P(DGINS(DGVAL,1),U,2),1,10),1:"UNKNOWN")
 S X=+DGINS(DGVAL,7) I X'="" S X=$S(X=1:"p",X=2:"s",X=3:"t",1:"")
 W ?(14+OFF),X
 W ?(17+OFF),$E(DGINS(DGVAL,14),1,16)
 W ?(35+OFF),$E(DGINS(DGVAL,18),1,10)
 S DGX=$P(DGINS(DGVAL,12),U,1)
 W ?(47+OFF),$S(DGX="P":"SELF",DGX="S":"SPOUSE",1:"OTHER")
 W ?(55+OFF),$TR($$FMTE^XLFDT(DGINS(DGVAL,10),"2DF")," ","0"),?(65+OFF+$S(OFF:1,1:0)),$TR($$FMTE^XLFDT(DGINS(DGVAL,11),"2DF")," ","0")
 I 'OFF D
 .I $P(DGINS(DGVAL,9),U,2)="NO" W ?75,"*WNR*" Q
 Q
