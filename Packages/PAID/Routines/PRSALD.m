PRSALD ;HISC/MGD-Labor Distribution Codes Edit ;06/28/2003
 ;;4.0;PAID;**82,114,115**;Sep 21, 1995;Build 2
 ;;Per VHA Directive 2004-038, this routine should not be modified.
 ;Patch *115 modifies tag POST to display via roll & scroll in place of Screenman view
 Q
PAY ; Payroll Entry
 N PPERIOD,PRSCNT,PRSDSH,PRSLIN,PRSREC,PRSQUIT
 S PRSTLV=7
P1 K DIC S DIC("A")="Select EMPLOYEE: ",DIC(0)="AEQM",DIC="^PRSPC("
 W ! D ^DIC S DFN=+Y K DIC G:DFN<1 EX
 S TLE=$P($G(^PRSPC(DFN,0)),"^",8)
 D POST
 G P1
 Q
TL ; Timekeeper Entry. Select T & L Unit
 N PP,PPE,PPI,PRSTLV,TLI
 S PRSTLV=2 D ^PRSAUTL G:TLI<1 EX
 ;
LASTPP ; Get Last PP received in 459
 S PP="A"
 S PP=$O(^PRST(459,PP),-1)
 S PPE=$P($G(^PRST(459,PP,0)),"^",1)
 S PPI=""
 S PPI=$O(^PRST(458,"B",PPE,PPI))
 S PPE=PPE_"  "_$P($G(^PRST(458,PPI,2)),"^",1)_" -> "_$P($G(^PRST(458,PPI,2)),"^",14)
 ;
NME ; Select individual employee
 K DIC S DIC("A")="Select EMPLOYEE: ",DIC("S")="I $P(^(0),""^"",8)=TLE,$D(^PRST(458,PPI,""E"",+Y))",DIC(0)="AEQM",DIC="^PRSPC(",D="ATL"_TLE W ! D IX^DIC S DFN=+Y K DIC
 G:DFN<1 EX S GLOB="" D POST D:GLOB]"" UNLOCK^PRSLIB00(GLOB) G NME
 ;
EX ; Clean up variables and Exit
 K D,DA,DDSFILE,DFN,DR,GLOB,LP,NN,TLE,Y,ZS,%
 G KILL^XUSCLEAN
 ;
POST ; Edit & Post Labor Distribution Codes
 Q:'DFN
 S DA=DFN,PRSDSH="",PRSLIN="",$P(PRSDSH,"-",81)="",$P(PRSLIN,"_",81)=""
 ;S DDSFILE=450,DR="[PRSA LD POST]"
 ;D ^DDS K DS Q:'$D(ZS)
 ;new roll & scroll display for labor dist
 S PRSREC=$G(^PRSPC(DFN,0))
 W @IOF,$P(PRSREC,U),?26,"VA TIME & ATTENDANCE SYSTEM" S Y=$P(PRSREC,U,9) W ?68,$S(PRSTLV=2&Y:$E(Y)_"XX-XX-"_$E(Y,6,9),PRSTLV=7&Y:$E(Y,1,3)_"-"_$E(Y,4,5)_"-"_$E(Y,6,9),1:"XXX-XX-XXXX")
 W !,"Station: ",$P(PRSREC,U,8),?28,"Labor Distribution Codes",?71,"T&L: ",$P(PRSREC,U,8)
 W !,?21,$G(PPE)
 W !!,?12,"CODE",?24,"PERCENT",?40,"COST CENTER",?59,"FUND CTRL PT",!,PRSDSH
 F PRSCNT=1:1:4 S PRSREC=$G(^PRSPC(DA,"LD",PRSCNT,0)) W !,"LD CODE" I PRSREC'="" W ?8,PRSCNT,?12,$P(PRSREC,U,2),?25,$P(PRSREC,U,3),?43,$P(PRSREC,U,4),?64,$P(PRSREC,U,5)
 W !!!
 F PRSCNT=1:1:4 S PRSREC=$G(^PRSPC(DA,"LD",PRSCNT,0)) W !,"COST CENTER" I PRSREC'="" W ?12,PRSCNT,?14,$P(PRSREC,U,4),?21 D
 . S Y=$P(PRSREC,U,4),SUB454="CC" D OT^PRSDUTIL
 . K SUB454 S PRSREC=Y
 . W PRSREC
 W !!,PRSLIN,!!!,"END OF DISPLAY, HIT RETURN TO QUIT" R PRSQUIT:120
 W @IOF
 Q
 ;
 ; The following code will be implemented in Phase 2 of the Labor Dist.
 ;
D2 ; Select All or individual employee
 W !!,"Would you like to edit the Labor Codes in alphabetical order"
 S %=1 D YN^DICN I % S LP=% G EX:%=-1,LOOP:%=1,NME
 W !!,"Answer YES if you want all RECORDs brought up for which no data"
 W !,"has been entered." G D2
 Q
 ;
LOOP ; Loop through all employees in selected T & L
 S LP=1,NN=""
 F  S NN=$O(^PRSPC("ATL"_TLE,NN)) Q:NN=""  D
 . F DFN=0:0 S DFN=$O(^PRSPC("ATL"_TLE,NN,DFN)) Q:DFN<1  D
 . . S GLOB="" D POST D:GLOB]"" UNLOCK^PRSLIB00(GLOB) I 'LP G EX
 G EX
 Q
 ;
PP ; Select Pay Period
 S DIC="^PRST(458,",DIC(0)="AEQZ",D="B"
 D IX^DIC
 Q:Y=-1
 S PPI=+Y,PPE="PP "_$P(Y,"^",2)_"   "
 S PPE=PPE_$P($G(^PRST(458,PPI,2)),"^",1)_" -> "_$P($G(^PRST(458,PPI,2)),"^",14)
 ;
LDOUT ; Convert LABOR DIST CODE EDITED BY field into its external format.
 ;
 I "IETP"'[Y&('+Y) D  Q
 . S Y="Unknown"
 I Y="I" S Y="Initial Download"
 I Y="E" S Y="Edit & Update Download"
 I Y="T" S Y="Transfer Download"
 I Y="P" S Y="Payrun Download"
 I +Y D
 . S Y=$P($G(^VA(200,Y,0)),"^",1)
 . I Y="" S Y="Unknown"
 Q
