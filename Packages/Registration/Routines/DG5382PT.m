DG5382PT ; ALBANY/GTS - DG*5.3*82 POST INIT; 1/30/96-11:45AM
 ;;5.3;Registration;**82**;Jan 30, 1996
 ;
MAIN ;
 D SETWARD ;** Correct the WARD LOCATION entry in file 39.2
 D SETCARD ;** Change the layout of the WRISTBAND entry in file 39.1
 D:XPDQUES("POS1 QUESTION") SETTERM ;** Set Term Type file (#3.2) entry
 Q
 ;
SETWARD ;** Change the mumps code for the WARD LOCATION lookup
 N DGWLDA,CODE
 S CODE="S Y="""" I $G(^DPT(DFN,.1))]"""" S Y=$O(^DIC(42,""B"",$G(^DPT(DFN,.1)),0)) S Y=$S($P($G(^DIC(42,+Y,0)),U,4)=""N"":"""",1:$P($G(^DIC(42,+Y,0)),U))"
 S DIC="^DIC(39.2,",DIC(0)="M",X="WARD LOCATION"
 D ^DIC
 S DGWLDA=+Y
 K DIC,X,Y
 I DGWLDA DO
 .S DIE="^DIC(39.2,",DA=DGWLDA
 .S DR="1///^S X=CODE"
 .D ^DIE
 .K DIE,DA,DR
 Q
 ;
SETCARD ;** Change the layout of the WRISTAND in the EMBOSSED CARD TYPE file
 ;** VARIABLE DEFS
 ;
 ; DGECDA    - IEN for 39.1 file
 ; DGLNDA    - IEN for 39.11 file
 ; DGECLNDA  - Value of LINE NUMBER field
 ; DGLNX     - One line from WBDEF defining an entry in 39.11
 ; DGDATA    - One piece of WBDEF text defining an entry in 39.12
 ; DGITEM    - DATA ITEM field literal value for field
 ; DGCOL     - Value of STARTING COLUMN field
 ; DGLNG     - Value of LENGTH field
 ;
 N DGECDA,DGECLNDA,DGDATA,DGLNX,DGITEM,DGCOL,DGLNG,DGLNDA
 S DIC="^DIC(39.1,",DIC(0)="M",X="WRISTBAND"
 D ^DIC ;** Get WRISTBAND DA from file 39.1
 S DGECDA=+Y
 K DIC,X,Y
 I DGECDA DO
 .S DGECLNDA=0
 .F  S DGECLNDA=DGECLNDA+1 S DGLNX=$P($T(WBDEF+DGECLNDA),";;",2) Q:DGLNX["QUIT"  DO
 ..S DA(1)=DGECDA,DIC="^DIC(39.1,"_DA(1)_",1,"
 ..S DIC(0)="L"
 ..S DIC("P")=$P(^DD(39.1,10,0),"^",2)
 ..S X=DGECLNDA
 ..K DD,DO
 ..D FILE^DICN
 ..S DGLNDA=+Y
 ..K DIC,DA,X,Y
 ..S DGPCE=1
 ..D SUBENT ;** Pull one data item from DGLNX, add to multiple
 K DIC,DA,X,Y
 Q
 ;
SUBENT ;** Create the data items on one line of the wristband
 F  S DGDATA=$P(DGLNX,"~~",DGPCE) Q:DGDATA=""  DO
 .S DGPCE=DGPCE+1
 .I DGLNDA DO
 ..S X=""
 ..S DGITEM=$P(DGDATA,"^",1)
 ..S:DGITEM'="" X=$O(^DIC(39.2,"B",DGITEM,X))
 ..I X DO
 ...S DGCOL=$P(DGDATA,"^",2)
 ...S DGLNG=$P(DGDATA,"^",3)
 ...S DA(2)=DGECDA,DA(1)=DGLNDA,DIC="^DIC(39.1,"_DA(2)_",1,"_DA(1)_",1,"
 ...S DIC(0)="L"
 ...S DIC("P")=$P(^DD(39.11,1,0),"^",2)
 ...S DIC("DR")="1///^S X=DGCOL;2///^S X=DGLNG"
 ...K DD,DO
 ...D FILE^DICN
 ..K DIC,DA,X,Y
 Q
 ;
SETTERM ;** Edit entry in TERMINAL TYPE file (#3.2)
 N DGTTDA,CODE1,CODE2,CODE3,CODE4,OPENE,BARON,BAROFF
 S DIC="^%ZIS(2,",DIC(0)="M",X="P-BARCODE BLAZER"
 D ^DIC
 S DGTTDA=+Y
 K DIC,X,Y
 I DGTTDA DO
 .S CODE1="U B9X12 (3,2,90) 160 100 "
 .S CODE2="U B9X12 (2,2,90) 140 100 "
 .S CODE3="R90 9X12 130 100 "
 .S CODE4="R90 9X12 125 100 "
 .S OPENE="W ""! 0 75 750 1"",!,""V MODE 0"",!,""V ENCODER 1"",!,""V SPEED 3.25 1.2"",!,""PITCH 100"",!"
 .S BARON="""BARCODER CODE39(2:4) 80 100 40 *"",VARIABLE,""*"",!"
 .S BAROFF="""END"",!"
 .S DIE="^%ZIS(2,",DA=DGTTDA
 .S DR="6///^S X=OPENE;60///^S X=BARON;61///^S X=BAROFF;203///^S X=CODE1;205///^S X=CODE2;207///^S X=CODE3;209///^S X=CODE4"
 .D ^DIE
 .K DIE,DA,DR
 Q
 ;
WBDEF ;;**Define wristband layout
 ;;NAME^1^30
 ;;PID^1^14~~DOB^16^6~~WARD LOCATION^14^15
 ;;BLANK^1^1
 ;;ALLERGY^1^40~~RELIGION^30^2
 ;;QUIT
