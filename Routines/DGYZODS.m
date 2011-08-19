DGYZODS ;ALB/MIR - UTILITIES FOR ODS SOFTWARE ; 11 JAN 91
 ;;5.3;Registration;;Aug 13, 1993
 ;
 ;Determine if this patient is ODS and if software is on
 ;
 ;input DFN
 ;output:    DGODS - 1 if yes, 0 if no
 ;
 ;
ODS D ON I 'DGODS Q
 S DGODS=0 I $D(^DPT(DFN,.32)),$D(^DIC(21,+$P(^(.32),"^",3),0)),($P(^(0),"^",3)=6) S DGODS=1
 Q
 ;
ON ;is the ODS software turned on?
 ;
 D ON^A1B2UTL S DGODS=A1B2ODS
 K A1B2ODS Q
 ;
 ;
PT ;pass in DFN from register/admit.  If it doesn't exist, create a new entry.
 ;pass back DGODS=ifn of file
 ;
 ; INPUT  DFN
 ;
 ;  used:    DGONLY - means only ods patients (do software and patient
 ;                    checks if 1, just software checks if 0...for
 ;                    displaced vets)
 ;
 N DGONLY S DGONLY=1
PT1 N DA,DIC,DIK,SSN,X,Y
 I 'DFN!'$D(^DPT(DFN,0)) Q
 I $D(DGONLY) D ODS I 'DGODS Q
 I '$D(DGONLY) D ON I 'DGODS Q
 S DGODS=$O(^A1B2(11500.1,"AD",DFN,0)) I DGODS,$D(^A1B2(11500.1,DGODS,0)) Q
 S X(0)=^DPT(DFN,0),SSN=$P(X(0),"^",9) I SSN'?9N.E!($L(SSN)<9)!($L(SSN)>10) Q
 ;
 S X=SSN,DIC="^A1B2(11500.1,",DIC(0)="L"
 K DD,DO D FILE^DICN S DGODS=+Y Q:Y'>0
 F I=.32,"ODS" S X(I)=$S($D(^DPT(DFN,I)):^(I),1:"")
 D FAC^A1B2UTL
 S ^A1B2(11500.1,DGODS,0)=SSN_"^"_$P(X(0),"^",1)_"^"_$P(X(0),"^",3)_"^"_$P(X(.32),"^",5)_"^"_$P(X("ODS"),"^",3)_"^"_$P(X("ODS"),"^",2)_"^"_$S($D(^DPT(DFN,"DAC")):$P(^("DAC"),"^",1),1:"")_"^"_$S($D(DGONLY):1,1:0)_"^^^^"_DFN_"^"_A1B2FN
 S ^A1B2(11500.1,DGODS,.11)=$S($D(^DPT(DFN,.11)):^(.11),1:"") S X=^(.11),$P(^A1B2(11500.1,DGODS,.11),"^",7)=$S($D(^DIC(5,+$P(X,"^",5),1,+$P(X,"^",7),0)):$P(^(0),"^",1),1:"")
 S ^A1B2(11500.1,DGODS,1)=2
 S DA=DGODS,DIK=DIC D IX1^DIK
 Q
 ;
 ;
DFN ;Called from admit templates to N DFN
 N DFN S DFN=$P(^DGPM(DA,0),"^",3)
 D ODS
 Q
