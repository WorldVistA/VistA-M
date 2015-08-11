IBVCB2 ;LITS/MRD - VIEW CANCELLED BILL, CONT. ;25-JUN-14
 ;;2.0;INTEGRATED BILLING;**516**;21-MAR-94;Build 123
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
PART3 ; User Data, Payment & Claim History, Insurance, etc.
 ;
 N IBADD1,IBADD2,IBADDTOT,IBDISAPP,IBCITY,IBFIND,IBFIND2,IBLINE,IBNAME,IBPROV,IBPROVID,IBRETURN,IBROLE,IBROLEX,IBSTATE,IBX,IBZIP
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Procedure Codes (Line Level Data)"
 S IBTEXT(3,1)="---------------------------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBFIND=0,IBLINE=0
 F  S IBLINE=$O(^DGCR(399,IBIFN,"CP",IBLINE)) Q:'IBLINE  D
 . ; Print a blank line if this is not the first procedure.
 . I IBFIND S IBTEXT(1,1)="" D LINE^IBVCB(.IBTEXT)
 . S IBFIND=1
 . ;
 . S IBTEXT(1,1)="Procedure: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",.01,"E")
 . S IBTEXT(1,2)="Date: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",1,"E")
 . S IBX=$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",51,"E")
 . I IBX'="" S IBTEXT(2,1)="NOC Description: "_IBX
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . S IBTEXT(1,1)="Print Order: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",3,"E")
 . S IBTEXT(1,2)="Division: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",5,"E")
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . S IBTEXT(1,1)="Clinic: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",6,"E")
 . S IBTEXT(1,2)="Place of Service: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",8,"E")
 . S IBTEXT(2,1)="Type of Service: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",9,"E")
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . S IBTEXT(1,1)="Assoc DX(1): "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",10,"E")
 . S IBTEXT(1,2)="Assoc DX(2): "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",11,"E")
 . S IBTEXT(2,1)="Assoc DX(3): "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",12,"E")
 . S IBTEXT(2,2)="Assoc DX(4): "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",13,"E")
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . S IBFIND2=0,IBX=0
 . F  S IBX=$O(^DGCR(399,IBIFN,"CP",IBLINE,"MOD",IBX)) Q:'IBX  D
 . . S IBFIND2=1
 . . S IBTEXT(1,1)="Modifier Sequence: "_$$GET1^DIQ(399.30416,IBX_","_IBLINE_","_IBIFN_",",.01,"E")
 . . S IBTEXT(1,2)="Modifier: "_$$GET1^DIQ(399.30416,IBX_","_IBLINE_","_IBIFN_",",.02,"E")
 . . D LINE^IBVCB(.IBTEXT)
 . . Q
 . I 'IBFIND2 D
 . . S IBTEXT(1,1)="*** No Modifier Data Found ***"
 . . D LINE^IBVCB(.IBTEXT)
 . . Q
 . ;
 . S IBTEXT(1,1)="Anest Minutes: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",15,"E")
 . S IBTEXT(1,2)="Add OB Minutes: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",74,"E")
 . S IBTEXT(2,1)="Emergency?: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",17,"E")
 . S IBTEXT(2,2)="Encounter: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",20,"E")
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . S IBTEXT(1,1)="Purchased Cost: "_$$DOLLAR^IBVCB($$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",19,"E"))
 . S IBTEXT(1,2)="Hours: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",22,"E")
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . S IBTEXT(1,1)="Attending Not Hospice Employee: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",50.03,"E")
 . S IBTEXT(1,2)="EPSDT Flag: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",50.07,"E")
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . S IBTEXT(1,1)="Comment Qualifier: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",50.09,"E")
 . S IBTEXT(2,1)="Comment: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",50.08,"E")
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . S IBTEXT(1,1)="Attachment Report Type: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",71,"E")
 . S IBTEXT(2,1)="Attachment Report Transmit Method: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",72,"E")
 . S IBTEXT(3,1)="Attachment Control No.: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",70,"E")
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . S IBTEXT(1,1)="NDC: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",53,"E")
 . S IBTEXT(1,2)="NDC Units: "_$$GET1^DIQ(399.0304,IBLINE_","_IBIFN_",",54,"E")
 . D LINE^IBVCB(.IBTEXT)
 . ;
 . F IBROLE=4,3,2,9,1,5 D
 . . S IBROLEX=$S(IBROLE=1:"Referring",IBROLE=2:"Operating",IBROLE=3:"Rendering",IBROLE=4:"Attending",IBROLE=5:"Supervising",IBROLE=9:"Other Oper.",1:"")
 . . S IBPROV=0
 . . F  S IBPROV=$O(^DGCR(399,IBIFN,"CP",IBLINE,"LNPRV",IBPROV)) Q:'IBPROV  D
 . . . I IBROLE'=$P(^DGCR(399,IBIFN,"CP",IBLINE,"LNPRV",IBPROV,0),U) Q
 . . . ;
 . . . S IBTEXT(1,1)=IBROLEX_": "_$$GET1^DIQ(399.0404,IBPROV_","_IBLINE_","_IBIFN_",",.02,"E")
 . . . S IBTEXT(1,2)="Credentials: "_$$GET1^DIQ(399.0404,IBPROV_","_IBLINE_","_IBIFN_",",.03,"E")
 . . . ;
 . . . S IBTEXT(2,1)="Specialty: "_$$GET1^DIQ(399.0404,IBPROV_","_IBLINE_","_IBIFN_",",.08,"E")
 . . . S IBTEXT(2,2)="Taxonomy: "_$$GET1^DIQ(399.0404,IBPROV_","_IBLINE_","_IBIFN_",",.15,"E")
 . . . ;
 . . . S IBPROVID=$$GET1^DIQ(399.0404,IBPROV_","_IBLINE_","_IBIFN_",",.12,"E")_"/"_$$GET1^DIQ(399.0404,IBPROV_","_IBLINE_","_IBIFN_",",.05,"E")
 . . . S IBTEXT(3,1)="Prim Payer Qual/ID: "_IBPROVID
 . . . S IBPROVID=$$GET1^DIQ(399.0404,IBPROV_","_IBLINE_","_IBIFN_",",.13,"E")_"/"_$$GET1^DIQ(399.0404,IBPROV_","_IBLINE_","_IBIFN_",",.06,"E")
 . . . S IBTEXT(3,2)="Sec Payer Qual/ID: "_IBPROVID
 . . . ;
 . . . S IBPROVID=$$GET1^DIQ(399.0404,IBPROV_","_IBLINE_","_IBIFN_",",.14,"E")_"/"_$$GET1^DIQ(399.0404,IBPROV_","_IBLINE_","_IBIFN_",",.07,"E")
 . . . S IBTEXT(4,1)="Tert Payer Qual/ID: "_IBPROVID
 . . . D LINE^IBVCB(.IBTEXT)
 . . . ;
 . . . Q
 . . Q
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="*** No Line Level Data Found ***"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="User Data"
 S IBTEXT(3,1)="---------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Date Entered: "_$$GET1^DIQ(399,IBIFN_",",1,"E")
 S IBTEXT(1,2)="Entered/Edited By: "_$$GET1^DIQ(399,IBIFN_",",2,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Initial Review Date: "_$$GET1^DIQ(399,IBIFN_",",4,"E")
 S IBTEXT(1,2)="Reviewed By: "_$$GET1^DIQ(399,IBIFN_",",5,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Authorization Date: "_$$GET1^DIQ(399,IBIFN_",",10,"E")
 S IBTEXT(1,2)="Authorized By: "_$$GET1^DIQ(399,IBIFN_",",11,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Date Cancelled: "_$$GET1^DIQ(399,IBIFN_",",17,"E")
 S IBTEXT(1,2)="Cancelled By: "_$$GET1^DIQ(399,IBIFN_",",18,"E")
 S IBTEXT(2,1)="Reason Cancelled: "_$$GET1^DIQ(399,IBIFN_",",19,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="MRA Request Date: "_$$GET1^DIQ(399,IBIFN_",",7,"E")
 S IBTEXT(1,2)="Requested By: "_$$GET1^DIQ(399,IBIFN_",",8,"E")
 S IBTEXT(2,1)="MRA Request Status: "_$$GET1^DIQ(399,IBIFN_",",24,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Date First Printed: "_$$GET1^DIQ(399,IBIFN_",",12,"E")
 S IBTEXT(1,2)="Printed By: "_$$GET1^DIQ(399,IBIFN_",",13,"E")
 S IBTEXT(2,1)="Date Last Printed: "_$$GET1^DIQ(399,IBIFN_",",14,"E")
 S IBTEXT(2,2)="Printed By: "_$$GET1^DIQ(399,IBIFN_",",15,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Billing Provider"
 S IBTEXT(3,1)="----------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Prim Payer ID: "_$$GET1^DIQ(399,IBIFN_",",122,"E")
 S IBTEXT(1,2)="ID Qualifier: "_$$GET1^DIQ(399,IBIFN_",",128,"E")
 S IBTEXT(2,1)="Sec Payer ID: "_$$GET1^DIQ(399,IBIFN_",",123,"E")
 S IBTEXT(2,2)="ID Qualifier: "_$$GET1^DIQ(399,IBIFN_",",129,"E")
 S IBTEXT(3,1)="Tert Payer ID: "_$$GET1^DIQ(399,IBIFN_",",124,"E")
 S IBTEXT(3,2)="ID Qualifier: "_$$GET1^DIQ(399,IBIFN_",",130,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Taxonomy: "_$$GET1^DIQ(399,IBIFN_",",252,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Primary Care Unit: "_$$GET1^DIQ(399,IBIFN_",",239,"E")
 S IBTEXT(1,2)="Secondary Care Unit: "_$$GET1^DIQ(399,IBIFN_",",240,"E")
 S IBTEXT(2,1)="Tertiary Care Unit: "_$$GET1^DIQ(399,IBIFN_",",241,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Prior Payment Information"
 S IBTEXT(3,1)="-------------------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Offset Amount: "_$$DOLLAR^IBVCB($$GET1^DIQ(399,IBIFN_",",202,"E"))
 S IBTEXT(1,2)="Offset Desc: "_$$GET1^DIQ(399,IBIFN_",",203,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Primary Payment: "_$$DOLLAR^IBVCB($$GET1^DIQ(399,IBIFN_",",218,"E"))
 S IBTEXT(1,2)="Secondary Payment: "_$$DOLLAR^IBVCB($$GET1^DIQ(399,IBIFN_",",219,"E"))
 S IBTEXT(2,1)="Tertiary Payment: "_$$DOLLAR^IBVCB($$GET1^DIQ(399,IBIFN_",",220,"E"))
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Claim History"
 S IBTEXT(3,1)="-------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Bill Cloned To: "_$$GET1^DIQ(399,IBIFN_",",29,"E")
 S IBTEXT(1,2)="Bill Cloned From: "_$$GET1^DIQ(399,IBIFN_",",30,"E")
 S IBTEXT(2,1)="Date Cloned: "_$$GET1^DIQ(399,IBIFN_",",31,"E")
 S IBTEXT(2,2)="Cloned By: "_$$GET1^DIQ(399,IBIFN_",",32,"E")
 S IBTEXT(3,1)="Reason Cloned: "_$$GET1^DIQ(399,IBIFN_",",33,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Auto-process From: "_$$GET1^DIQ(399,IBIFN_",",34,"E")
 S IBTEXT(1,2)="Auto-process Result: "_$$GET1^DIQ(399,IBIFN_",",35,"E")
 S IBTEXT(2,1)="Auto-process Reason: "_$$GET1^DIQ(399,IBIFN_",",36,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Remove Worklist Date:: "_$$GET1^DIQ(399,IBIFN_",",39,"E")
 S IBTEXT(1,2)="Remove Worklist By: "_$$GET1^DIQ(399,IBIFN_",",37,"E")
 S IBTEXT(2,1)="Remove Worklist How: "_$$GET1^DIQ(399,IBIFN_",",38,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 ; List all reasons disapproved beneath both node "D1" and node "D2".
 ;
 S IBFIND=0,IBDISAPP=0
 F  S IBDISAPP=$O(^DGCR(399,IBIFN,"D1",IBDISAPP)) Q:'IBDISAPP  D
 . S IBFIND=1
 . S IBTEXT(1,1)="Reason(s) Disapproved (1): "_$$GET1^DIQ(399.044,IBDISAPP_","_IBIFN_",",.01,"E")
 . D LINE^IBVCB(.IBTEXT)
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="Reason(s) Disapproved (1):"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBFIND=0,IBDISAPP=0
 F  S IBDISAPP=$O(^DGCR(399,IBIFN,"D2",IBDISAPP)) Q:'IBDISAPP  D
 . S IBFIND=1
 . S IBTEXT(1,1)="Reason(s) Disapproved (2): "_$$GET1^DIQ(399.045,IBDISAPP_","_IBIFN_",",.01,"E")
 . D LINE^IBVCB(.IBTEXT)
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="Reason(s) Disapproved (2):"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 ; List all Returned data.
 ;
 S IBFIND=0,IBRETURN=0
 F  S IBRETURN=$O(^DGCR(399,IBIFN,"R",IBRETURN)) Q:'IBRETURN  D
 . S IBTEXT(1,1)="Date Returned: "_$$GET1^DIQ(399.046,IBRETURN_","_IBIFN_",",.01,"E")
 . S IBTEXT(1,2)="Returned By: "_$$GET1^DIQ(399.046,IBRETURN_","_IBIFN_",",.02,"E")
 . S IBTEXT(2,1)="Return Comments: "_$$GET1^DIQ(399.046,IBRETURN_","_IBIFN_",",.03,"E")
 . D LINE^IBVCB(.IBTEXT)
 . Q
 I 'IBFIND D
 . S IBTEXT(1,1)="Date Returned:"
 . S IBTEXT(1,2)="Returned By:"
 . S IBTEXT(2,1)="Return Comments:"
 . D LINE^IBVCB(.IBTEXT)
 . Q
 ;
 S IBTEXT(1,1)="Prim Bill No.: "_$$GET1^DIQ(399,IBIFN_",",125,"E")
 S IBTEXT(1,2)="Sec Bill No.: "_$$GET1^DIQ(399,IBIFN_",",126,"E")
 S IBTEXT(2,1)="Tert Bill No.: "_$$GET1^DIQ(399,IBIFN_",",127,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)="Insurance Company(s)"
 S IBTEXT(3,1)="--------------------"
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)="Primary: "_$$GET1^DIQ(399,IBIFN_",",101,"E")
 S IBTEXT(2,1)="Secondary: "_$$GET1^DIQ(399,IBIFN_",",102,"E")
 S IBTEXT(3,1)="Tertiary: "_$$GET1^DIQ(399,IBIFN_",",103,"E")
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBNAME=$$GET1^DIQ(399,IBIFN_",",104,"E")
 S IBADD1=$$GET1^DIQ(399,IBIFN_",",105,"E")
 S IBADD2=$$GET1^DIQ(399,IBIFN_",",106,"E")
 S IBCITY=$$GET1^DIQ(399,IBIFN_",",107,"E")
 S IBSTATE=$$GET1^DIQ(399,IBIFN_",",108,"E")
 S IBZIP=$$GET1^DIQ(399,IBIFN_",",109,"E")
 S IBADDTOT=IBNAME_" "_IBADD1_" "_IBADD2_" "_IBCITY_" "_IBSTATE_" "_IBZIP
 S IBTEXT(1,1)="Current Payer Address: "_IBADDTOT
 D LINE^IBVCB(.IBTEXT)
 ;
 S IBTEXT(1,1)=""
 S IBTEXT(2,1)=""
 D LINE^IBVCB(.IBTEXT)
 ;
 Q
 ;
