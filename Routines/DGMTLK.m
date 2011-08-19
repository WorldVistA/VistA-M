DGMTLK ;ALB/RMO - Look-up a Means Test for a Patient ;28 MAY 1992 10:41 am
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ; Input  -- DFN      Patient IEN
 ;           DIC      DIC variables as defined by FM ^DIC call
 ;                    DIC("A"), DIC("B"), DIC("S") are Optional
 ;                    Special Notes:
 ;                     - DIC(0) should NOT contain A, M or N for
 ;                       performance purposes
 ;                     - DIC("B") should be in internal format and will
 ;                       be converted to external format when displayed
 ; Output -- All variables as defined by FM ^DIC call
 ;
EN ;Entry point to look-up a means test for a patient
 W !,$S($D(DIC("A")):DIC("A"),1:"Select DATE OF TEST: ") I $D(DIC("B")) S %=DIC("B") D DT^DGUTL K % W "// "
 R X:DTIME I '$T S DTOUT=1,Y=-1 G Q
 I X="",$D(DIC("B")) S X=DIC("B")
 S:X["^" DUOUT=1 I X["^"!(X="") S Y=-1 G Q
 I X["?" S D="ADFN"_DFN D IX^DIC K D G EN
 D ^DIC G EN:Y<0
Q Q
