IBVCB1 ;LITS/MRD - VIEW CANCELLED BILL, CONT. ;25-JUN-14
 ;;2.0;INTEGRATED BILLING;**516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PART2 ; Chiropractic Data, Ambulance Data, etc.
 ;
 N IBADD1,IBADD2,IBCITY,IBCOM1,IBCOM2,IBDOADD,IBFIND,IBPROV,IBPROVID,IBPUADD,IBREVCD,IBROLE,IBROLEX,IBSTATE,IBX,IBX1,IBX2,IBX3,IBX4,IBX5,IBX6,IBZIP
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Chiropractic Data"
 S IBTEXT(3,1)="-----------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBX1=$$GET1^DIQ(399,IBIFN_",",246,"E")
 S IBX2=$$GET1^DIQ(399,IBIFN_",",245,"E")
 S IBX3=$$GET1^DIQ(399,IBIFN_",",247,"E")
 S IBX4=$$GET1^DIQ(399,IBIFN_",",248,"E")
 I (IBX1_IBX2_IBX3_IBX4)'="" D
 . S IBTEXT(1,1)="Initial TX Date: "_IBX1
 . S IBTEXT(1,2)="Last XRAY Date: "_IBX2
 . S IBTEXT(2,1)="Acute Manifestation Date: "_IBX3
 . S IBTEXT(2,2)="Condition Code: "_IBX4
 . D LINE^IBVCB(.IBTEXT)
 . Q
 E  D
 . S IBTEXT(1,1)="*** No Chiropractic Data Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Ambulance Data"
 S IBTEXT(3,1)="--------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBADD1=$$GET1^DIQ(399,IBIFN_",",271,"E")
 S IBADD2=$$GET1^DIQ(399,IBIFN_",",272,"E")
 S IBCITY=$$GET1^DIQ(399,IBIFN_",",273,"E")
 S IBSTATE=$$GET1^DIQ(399,IBIFN_",",274,"E")
 S IBZIP=$$GET1^DIQ(399,IBIFN_",",275,"E")
 S IBPUADD=IBADD1_" "_IBADD2_" "_IBCITY_" "_IBSTATE_" "_IBZIP
 ;
 S IBTEXT(1,1)="D/O Location: "_$$GET1^DIQ(399,IBIFN_",",276,"E")
 S IBADD1=$$GET1^DIQ(399,IBIFN_",",277,"E")
 S IBADD2=$$GET1^DIQ(399,IBIFN_",",278,"E")
 S IBCITY=$$GET1^DIQ(399,IBIFN_",",279,"E")
 S IBSTATE=$$GET1^DIQ(399,IBIFN_",",280,"E")
 S IBZIP=$$GET1^DIQ(399,IBIFN_",",281,"E")
 S IBDOADD=IBADD1_" "_IBADD2_" "_IBCITY_" "_IBSTATE_" "_IBZIP
 ;
 S IBX1=$$GET1^DIQ(399,IBIFN_",",287,"E")
 S IBX2=$$GET1^DIQ(399,IBIFN_",",289,"E")
 S IBX3=$$GET1^DIQ(399,IBIFN_",",288,"E")
 S IBX4=$$GET1^DIQ(399,IBIFN_",",290,"E")
 S IBX5=$$GET1^DIQ(399,IBIFN_",",291,"E")
 ;
 I (IBPUADD_IBDOADD_IBX1_IBX2_IBX3_IBX4_IBX5)'="" D
 . S IBTEXT(1,1)="P/U Address: "_IBPUADD
 . S IBTEXT(2,1)="D/O Address: "_IBDOADD
 . S IBTEXT(3,1)="Pt. Weight: "_IBX1
 . S IBTEXT(3,2)="Transport Distance: "_IBX2
 . S IBTEXT(4,1)="Transport Reason: "_IBX3
 . S IBTEXT(5,1)="R/T Purpose: "_IBX4
 . S IBTEXT(6,1)="Stretcher Purpose: "_IBX5
 . D LINE^IBVCB(.IBTEXT)
 . Q
 E  D
 . S IBTEXT(1,1)="*** No Ambulance Data Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Ambulance Conditions"
 S IBTEXT(3,1)="--------------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBFIND=0,IBX=0
 F  S IBX=$O(^DGCR(399,IBIFN,"U9",IBX)) Q:'IBX  D
 . S IBFIND=1
 . S IBTEXT(1,1)="Ambulance Condition: "_$$GET1^DIQ(399.0292,IBX_","_IBIFN_",",.01,"E")
 . D LINE^IBVCB(.IBTEXT)
 . Q
 I 'IBFIND D
 . S IBTEXT(2,1)="*** No Ambulance Conditions Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Property & Casualty Data"
 S IBTEXT(3,1)="------------------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBX1=$$GET1^DIQ(399,IBIFN_",",261,"E")
 S IBX2=$$GET1^DIQ(399,IBIFN_",",262,"E")
 S IBX3=$$GET1^DIQ(399,IBIFN_",",268,"E")
 S IBX4=$$GET1^DIQ(399,IBIFN_",",269,"E")
 S IBX5=$$GET1^DIQ(399,IBIFN_",",269.1,"E")
 ;
 I (IBX1_IBX2_IBX3_IBX4)'="" D
 . S IBTEXT(1,1)="Claim Number: "_IBX1
 . S IBTEXT(1,2)="Date First Contact: "_IBX2
 . S IBTEXT(2,1)="Contact Name: "_IBX3
 . S IBTEXT(2,2)="Communication No.: "_IBX4_$S(IBX5'="":" Ext."_IBX5,1:"")
 . D LINE^IBVCB(.IBTEXT)
 . Q
 E  D
 . S IBTEXT(1,1)="*** No Property & Casualty Data Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Claim Level Providers"
 S IBTEXT(3,1)="---------------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBFIND=0
 F IBROLE=4,3,2,9,1,5 D
 . S IBROLEX=$S(IBROLE=1:"Referring",IBROLE=2:"Operating",IBROLE=3:"Rendering",IBROLE=4:"Attending",IBROLE=5:"Supervising",IBROLE=9:"Other Oper.",1:"")
 . S IBPROV=0
 . F  S IBPROV=$O(^DGCR(399,IBIFN,"PRV",IBPROV)) Q:'IBPROV  D
 . . I IBROLE'=$P(^DGCR(399,IBIFN,"PRV",IBPROV,0),U) Q
 . . S IBFIND=1
 . . ;
 . . S IBTEXT(1,1)=IBROLEX_": "_$$GET1^DIQ(399.0222,IBPROV_","_IBIFN_",",.02,"E")
 . . S IBTEXT(1,2)="Credentials: "_$$GET1^DIQ(399.0222,IBPROV_","_IBIFN_",",.03,"E")
 . . S IBTEXT(2,1)="Specialty: "_$$GET1^DIQ(399.0222,IBPROV_","_IBIFN_",",.08,"E")
 . . S IBTEXT(2,2)="Taxonomy: "_$$GET1^DIQ(399.0222,IBPROV_","_IBIFN_",",.15,"E")
 . . ;
 . . S IBPROVID=$$GET1^DIQ(399.0222,IBPROV_","_IBIFN_",",.12,"E")_"/"_$$GET1^DIQ(399.0222,IBPROV_","_IBIFN_",",.05,"E")
 . . S IBTEXT(3,1)="Prim Payer Qual/ID: "_IBPROVID
 . . S IBPROVID=$$GET1^DIQ(399.0222,IBPROV_","_IBIFN_",",.13,"E")_"/"_$$GET1^DIQ(399.0222,IBPROV_","_IBIFN_",",.06,"E")
 . . S IBTEXT(3,2)="Sec Payer Qual/ID: "_IBPROVID
 . . S IBPROVID=$$GET1^DIQ(399.0222,IBPROV_","_IBIFN_",",.14,"E")_"/"_$$GET1^DIQ(399.0222,IBPROV_","_IBIFN_",",.07,"E")
 . . S IBTEXT(4,1)="Tert Payer Qual/ID: "_IBPROVID
 . . D LINE^IBVCB(.IBTEXT)
 . . ;
 . . Q
 . Q
 I 'IBFIND D
 . S IBTEXT(5,1)="*** No Claim Level Providers Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Non-VA Facility Data - Fee"
 S IBTEXT(3,1)="--------------------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBX1=$$GET1^DIQ(399,IBIFN_",",232,"E")
 S IBX2=$$GET1^DIQ(399,IBIFN_",",233,"E")
 S IBX3=$$GET1^DIQ(399,IBIFN_",",234,"E")
 S IBX4=$$GET1^DIQ(399,IBIFN_",",244,"E")
 I (IBX1_IBX2_IBX3_IBX4)'="" D
 . S IBTEXT(1,1)="Facility: "_IBX1
 . S IBTEXT(1,2)="Care Type: "_IBX2
 . S IBTEXT(2,1)="Non-VA ID: "_IBX3
 . S IBTEXT(2,2)="Taxonomy: "_IBX4
 . D LINE^IBVCB(.IBTEXT)
 . Q
 E  D
 . S IBTEXT(1,1)="*** No Non-VA Facility Data Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Comments/Signature Block"
 S IBTEXT(3,1)="------------------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBX1=$$GET1^DIQ(399,IBIFN_",",400,"E")
 S IBX2=$$GET1^DIQ(399,IBIFN_",",459,"E")
 S IBX3=$$GET1^DIQ(399,IBIFN_",",402,"E")
 I (IBX1_IBX2_IBX3)'="" D
 . S IBTEXT(1,1)="Box 31 (CMS1500): "_IBX1
 . S IBTEXT(2,1)="Box 19 (CMS1500): "_IBX2
 . S IBTEXT(3,1)="FL 80 (UB04): "_IBX3
 . D LINE^IBVCB(.IBTEXT)
 . Q
 E  D
 . S IBTEXT(1,1)="*** No Comments/Signature Block Data Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="ECME Data"
 S IBTEXT(3,1)="---------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBX1=$$GET1^DIQ(399,IBIFN_",",460,"E")
 S IBX2=$$GET1^DIQ(399,IBIFN_",",461,"E")
 I (IBX1_IBX2)'="" D
 . S IBTEXT(1,1)="ECME Number: "_IBX1
 . S IBTEXT(1,2)="ECME Approval: "_IBX2
 . D LINE^IBVCB(.IBTEXT)
 . Q
 E  D
 . S IBTEXT(1,1)="*** No ECME Data Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="EOB/MRA Data"
 S IBTEXT(3,1)="------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBX1=$$GET1^DIQ(399,IBIFN_",",22,"E")
 S IBX2=$$GET1^DIQ(399,IBIFN_",",24,"E")
 S IBX3=$$GET1^DIQ(399,IBIFN_",",453,"E")
 S IBX4=$$GET1^DIQ(399,IBIFN_",",454,"E")
 S IBX5=$$GET1^DIQ(399,IBIFN_",",455,"E")
 I (IBX1_IBX2_IBX3_IBX4_IBX5)'="" D
 . S IBTEXT(1,1)="Date MRA Received: "_IBX1
 . S IBTEXT(1,2)="MRA Status: "_IBX2
 . S IBTEXT(2,1)="Primary ICN: "_IBX3
 . S IBTEXT(2,2)="Secondary ICN: "_IBX4
 . S IBTEXT(3,1)="Tertiary ICN: "_IBX5
 . D LINE^IBVCB(.IBTEXT)
 . Q
 E  D
 . S IBTEXT(1,1)="*** No EOB/MRA Data Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="PRV Diagnosis Codes"
 S IBTEXT(3,1)="-------------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBX1=$$GET1^DIQ(399,IBIFN_",",249,"E")
 S IBX2=$$GET1^DIQ(399,IBIFN_",",250,"E")
 S IBX3=$$GET1^DIQ(399,IBIFN_",",251,"E")
 I (IBX1_IBX2_IBX3)'="" D
 . S IBTEXT(1,1)="PRV #1: "_IBX1
 . S IBTEXT(1,2)="PRV #2: "_IBX2
 . S IBTEXT(2,1)="PRV #3: "_IBX3
 . D LINE^IBVCB(.IBTEXT)
 . Q
 E  D
 . S IBTEXT(1,1)="*** No PRV Diagnosis Code Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Comments"
 S IBTEXT(3,1)="--------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBFIND=0,IBCOM1=0
 F  S IBCOM1=$O(^DGCR(399,IBIFN,"TXC",IBCOM1)) Q:'IBCOM1  D
 . S IBCOM2=0
 . F  S IBCOM2=$O(^DGCR(399,IBIFN,"TXC",IBCOM1,1,IBCOM2)) Q:'IBCOM2  D
 . . S IBFIND=1
 . . S IBTEXT(1,1)="MRA WL Comments: "_$$GET1^DIQ(399.0771,IBCOM2_","_IBCOM1_","_IBIFN_",",.01,"E")
 . . S IBTEXT(2,1)="MRA WL Comments Date: "_$$GET1^DIQ(399.077,IBCOM1_","_IBIFN_",",.01,"E")
 . . S IBTEXT(2,2)="Entered By: "_$$GET1^DIQ(399.077,IBCOM1_","_IBIFN_",",.02,"E")
 . . D LINE^IBVCB(.IBTEXT)
 . . Q
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="*** No MRA WL Comments Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBFIND=0,IBCOM1=0
 F  S IBCOM1=$O(^DGCR(399,IBIFN,"TXC2",IBCOM1)) Q:'IBCOM1  D
 . S IBCOM2=0
 . F  S IBCOM2=$O(^DGCR(399,IBIFN,"TXC2",IBCOM1,1,IBCOM2)) Q:'IBCOM2  D
 . . S IBFIND=1
 . . S IBTEXT(1,1)="COB WL Comments: "_$$GET1^DIQ(399.0781,IBCOM2_","_IBCOM1_","_IBIFN_",",.01,"E")
 . . S IBTEXT(2,1)="COB WL Comments Date: "_$$GET1^DIQ(399.078,IBCOM1_","_IBIFN_",",.01,"E")
 . . S IBTEXT(2,2)="Entered By: "_$$GET1^DIQ(399.078,IBCOM1_","_IBIFN_",",.02,"E")
 . . D LINE^IBVCB(.IBTEXT)
 . . Q
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="*** No COB WL Comments Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Referral/Authorization Code"
 S IBTEXT(3,1)="---------------------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBX1=$$GET1^DIQ(399,IBIFN_",",163,"E")
 S IBX2=$$GET1^DIQ(399,IBIFN_",",230,"E")
 S IBX3=$$GET1^DIQ(399,IBIFN_",",231,"E")
 S IBX4=$$GET1^DIQ(399,IBIFN_",",253,"E")
 S IBX5=$$GET1^DIQ(399,IBIFN_",",254,"E")
 S IBX6=$$GET1^DIQ(399,IBIFN_",",255,"E")
 I (IBX1_IBX2_IBX3_IBX4_IBX5_IBX6)'="" D
 . S IBTEXT(1,1)="A/Primary: "_IBX1
 . S IBTEXT(1,2)="A/Secondary: "_IBX2
 . S IBTEXT(2,1)="A/Tertiary: "_IBX3
 . S IBTEXT(2,2)="R/Primary: "_IBX4
 . S IBTEXT(3,1)="R/Secondary: "_IBX5
 . S IBTEXT(3,2)="R/Tertiary: "_IBX6
 . D LINE^IBVCB(.IBTEXT)
 . Q
 E  D
 . S IBTEXT(1,1)="*** No Referral/Authorization Code Data Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Revenue Codes"
 S IBTEXT(3,1)="-------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBFIND=0,IBREVCD=0
 F  S IBREVCD=$O(^DGCR(399,IBIFN,"RC",IBREVCD)) Q:'IBREVCD  D
 . ; Print a blank line if this is not the first revenue code.
 . I IBFIND S IBTEXT(1,1)="" D LINE^IBVCB(.IBTEXT)
 . S IBFIND=1
 . S IBTEXT(1,1)="Code: "_$$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.01,"E")
 . S IBTEXT(1,2)="Number: "_$$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.001,"E")
 . ;
 . S IBTEXT(2,1)="Charges: "_$$DOLLAR^IBVCB($$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.02,"E"))
 . S IBTEXT(2,2)="Units: "_$$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.03,"E")
 . ;
 . S IBTEXT(3,1)="Total Charges: "_$$DOLLAR^IBVCB($$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.04,"E"))
 . S IBTEXT(3,2)="Bedsection: "_$$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.05,"E")
 . ;
 . S IBTEXT(4,1)="Procedure: "_$$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.06,"E")
 . S IBTEXT(4,2)="RX Procedure: "_$$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.15,"E")
 . ;
 . S IBTEXT(5,1)="Division: "_$$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.07,"E")
 . S IBTEXT(5,2)="Type: "_$$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.1,"E")
 . ;
 . S IBTEXT(6,1)="Non-covered Charges: "_$$DOLLAR^IBVCB($$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.09,"E"))
 . S IBTEXT(6,2)="Component: "_$$GET1^DIQ(399.042,IBREVCD_","_IBIFN_",",.12,"E")
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="*** No Revenue Codes Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 Q
 ;
