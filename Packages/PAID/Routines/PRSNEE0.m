PRSNEE0 ;WOIFO/PLT - Utility of Nurse POC Data A/E/D ; 08/14/2009  7:56 AM
 ;;4.0;PAID;**126**;Sep 21, 1995;Build 59
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 QUIT
 ;
 ;return value=^1 is 1 if primary or secondary is a 2-day tour ^2=meal time ^3=y if 2-day tour ^4=meal time of secondary ^5=y if 2-day tour of secondary
PSTOUR(PPI,DFN,PRSNDAY) ;ef - primary and secondary tour info
 N A,B
 S A=$G(^PRST(458,PPI,"E",DFN,"D",PRSNDAY,0))
 I A="" QUIT ""
 S B=$P($G(^PRST(457.1,+$P(A,U,2),0)),U,3)_U_$P($G(^(0)),U,5)
 S:$P(A,U,13)]"" B=B_U_$P($G(^PRST(457.1,+$P(A,U,13),0)),U,3)_U_$P($G(^(0)),U,5)
 QUIT $P(B,U,2)="Y"!($P(B,U,4)="Y")_U_B
 ;
 ;get prsnt array of tour of duty and exceptions from eta
 ;build prsnpc array from the prsnt array
 ;prsnpc(start militaty time)=^1-start time (military), ^2- stop time (military)
 ;              ^3-eta type of time, ^4-meal time
ETAPOC ;convert eta tour of duty and exceptions time segments to array prsnpc
 N A,B,C
 K PRSNT,PRSNPC D BLDTC^PRSNRMM(.PRSNT,DFN,PPI,PRSNDAY,1)
 S PRSNPC=$P(PRSNT,U)'=0_"^"_$P(PRSNT,U,2)
 S A=0 F  S A=$O(PRSNT(A)) QUIT:'A  S B=PRSNT(A) I $P(B,U,4) S A=$P(B,U,4),C=$G(PRSNT(A)),C=C+$S(C#100<45:15,1:55),PRSNPC(+B)=+B_U_C_U_$P(B,U,5)_U_$P(B,U,7)
 K PRSNT
 QUIT
 ;
ADDTS ;add poc time segments in file #451.9999 of file# 451
 N PRSNA,PRSNB,PRSNC
 S PRSNA=""
 F  S PRSNA=$O(PRSNPC(PRSNA)) QUIT:PRSNA=""  D
 . N X,Y,A,B,C,D
 . ;set x and x("r")
 . S A=PRSNPC(PRSNA),X=$E(A>2400*-2400+A+10000,2,5) D ^PRSATIM
 . S B=$P(A,U,2),C=$P(A,U,3),D=$P(A,U,4),B=$E(B>2400*-2400+B+10000,2,5)
 . S PRSNB=$S(",OT,CT,RG,"[C&(C]""):"V",1:""),PRSNC=$S(",WI,OT,CT,RG,HW,"'[C:"",$P(PRSNUR,U,4)="DC":$O(^PRSN(451.5,"B","DC",0)),1:"")
 . S X("DR")="1///"_B_";2////"_D_";3////"_C_";4////"_$P(PRSNLOC,U)_";5////"_PRSNC_";6////"_PRSNB_";8////"_$P(A,U)_";9////"_$P(A,U,2)
 . D ADD^PRSU1B1(.X,.Y,"451;;"_PPI_"~451.09;;"_DFN_"~451.99;;"_PRSNDAY_"~451.999;;"_PRSNVER_";~451.9999;^PRSN(451,PPI,""E"",DFN,""D"",PRSNDAY,""V"",PRSNVER,""T"",")
 . QUIT
 QUIT
 ;
 ;called from screenman form page 1 or page 1.5
 ;a=start time, b=stop time, c=1 if start time starts day 1, =2 if day 2
MILSS(A,B,C) ;ef:^1-military start time, ^2-military stop time, ^3 invalid message
 N X,Y,D,E
 S D="",E=""
 I A'="" S Y=0,X=A D MIL^PRSATIM S D=C-1*2400+Y
 I B'="" S Y=1,X=B D MIL^PRSATIM S Y=C-1*2400+Y,E=Y S:Y'>D E=2400+Y
 QUIT D_"^"_E_"^"_$S(E>2400&(C=1):"Stop Time is in the Second Day of the tour. Its Type of Time must be OT/CT/RG.",E>4800&(C=2):"Stop Time is in the Third Day of the tour.",1:"")
 ;
 ;data validation check before save
DATAVAL ;called from form for data validation
 N PRSNA,PRSNB,PRSNC,PRSND,PRSNE,PRSNERR,PRSNDIE,PRSNDA,PRSNTT,PRSNOTT,PRSNOTR,PRSNM
 S PRSNERR=0
 S PRSNDIE="^PRSN(451,"_PPI_",""E"","_DFN_",""D"","_PRSNDAY_",""V"","_PRSNVER_",""T"","
 S PRSNDA(4)=PPI,PRSNDA(3)=DFN,PRSNDA(2)=PRSNDAY,PRSNDA(1)=PRSNVER
 S PRSNDA=0
 F  S PRSNDA=$O(^PRSN(451,PPI,"E",DFN,"D",PRSNDAY,"V",PRSNVER,"T",PRSNDA)) QUIT:'PRSNDA  D
 . S PRSNA=$$GET^DDSVAL(PRSNDIE,.PRSNDA,.01)
 . S PRSNB=$$GET^DDSVAL(PRSNDIE,.PRSNDA,8)
 . S PRSNC=$$GET^DDSVAL(PRSNDIE,.PRSNDA,9)
 . S PRSNM=$$GET^DDSVAL(PRSNDIE,.PRSNDA,2)
 . S PRSNTT=$$GET^DDSVAL(PRSNDIE,.PRSNDA,3)
 . S PRSNOTT=$$GET^DDSVAL(PRSNDIE,.PRSNDA,6)
 . S PRSNOTR=$$GET^DDSVAL(PRSNDIE,.PRSNDA,7)
 . I PRSNTT'="",",OT,CT,RG,"[PRSNTT D
 .. I PRSNOTT="" S PRSNERR=PRSNERR+1,PRSNERR(PRSNERR)="Subrecord: "_PRSNA_" is missing overtime type"
 .. I PRSNOTR="" S PRSNERR=PRSNERR+1,PRSNERR(PRSNERR)="Subrecord: "_PRSNA_" is missing overtime reason"
 . I PRSNB=""!(PRSNC="") S PRSNERR=PRSNERR+1,PRSNERR(PRSNERR)="Subrecord: "_PRSNA_" has wrong Stop Time" QUIT
 . I $D(PRSNB(PRSNB)) S PRSNERR=PRSNERR+1,PRSNERR(PRSNERR)="Subrecord: "_PRSNA_" has duplicate Start Time" QUIT
 . S PRSNB(PRSNB)=PRSNC_"^"_PRSNA_"^"_PRSNM
 . QUIT
 S PRSNB=""
 F  S PRSNB=$O(PRSNB(PRSNB)) QUIT:PRSNB=""  D
 . S PRSNC=+PRSNB(PRSNB)
 . S PRSNM=$P(PRSNB(PRSNB),U,3)
 . I PRSNM,PRSNC\100*60+(PRSNC#100)-(PRSNB\100*60+(PRSNB#100))<PRSNM S PRSNERR=PRSNERR+1,PRSNERR(PRSNERR)="Meal Time is over Start/Stop Time."
 . S PRSND=$O(PRSNB(PRSNB))
 . S PRSNE=$O(PRSNB(PRSNC-1))
 . I PRSND'=PRSNE S PRSNERR=PRSNERR+1,PRSNERR(PRSNERR)="Subrecord: "_$P(PRSNB(PRSNB),U,2)_" has Stop Time greater than Start Time of the next time segment"
 . QUIT
 I PRSNERR D HLP^DDSUTL(.PRSNERR) S DDSERROR=1,DDSBR="1^2^1"
 QUIT
