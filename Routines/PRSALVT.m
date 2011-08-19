PRSALVT ; HISC/REL-Leave Increment ;9/12/2006
 ;;4.0;PAID;**111**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 S AINC="",SINC=""
 S C0=^PRSPC(DFN,0),LVG=$P(C0,"^",15),NH=+$P(C0,"^",16),DB=$P(C0,"^",10)
 Q:LVG'?1N!("12345"'[LVG)  G:NH>80 FF D @LVG G QT
1 ; Leave Group 1
 S AINC=$S(DB=1:4,1:NH+AINC/20\1),SINC=$S(DB=1:4,1:NH+SINC/20\1) Q
2 ; Leave Group 2
 S AINC=$S(DB=1:6,1:NH+AINC/13\1),SINC=$S(DB=1:4,1:NH+SINC/20\1) Q
3 ; Leave Group 3
 S AINC=$S(DB=1:8,1:NH+AINC/10\1),SINC=$S(DB=1:4,1:NH+SINC/20\1) Q
4 ; Leave Group 4
 S D1=$E(DT,1,3)_"1231" D PP^PRSAPPU S D1=$P(PPE,"-",2)
 I D1=26 S AINC=1,SINC=.5 Q
 S AINC=.963,SINC=.481 Q
5 ; Leave Group 5
 S D1=$E(DT,1,3)_"1231" D PP^PRSAPPU S D1=$P(PPE,"-",2)
 S SINC=$S(D1=26:.5,1:.481) Q
FF ; Firefighters
 I LVG=1 S AINC=$S(NH=112:5,NH=120:6,1:7)
 I LVG=2 S AINC=$S(NH=112:8,NH=120:9,1:11)
 I LVG=3 S AINC=$S(NH=112:11,NH=120:12,1:14)
 S SINC=$S(NH=112:5,NH=120:6,1:7)
QT ; Check Non-Accrual Flag
 S:$P($G(^PRSPC(DFN,"ANNUAL")),"^",1)="Y" AINC="" Q
