IBCOPP2 ;ALB/NLR - LIST INS. PLANS BY CO. (COMPILE) ; 20-OCT-2015
 ;;2.0;INTEGRATED BILLING;**28,62,93,516,528,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Queued Entry Point for Report.
 ; Input:   IBAI    - 0 - User selected Insurance Companies
 ;                    1 - Run report for all Insurance Companies with Plans
 ;          IBAIA   - 0 - Only select Inactive Insurance Companies
 ;                    1 - Only select Active Insurance Companies
 ;                    2 - Select both Active and Inactive Insurance Companies
 ;          IBAIPA    0 - Only select Inactive Insurance Company Plans
 ;                    1 - Only select Active Insurance Company Plans
 ;                    2 - Select both Active and Inactive Insurance Company Plans
 ;          IBAO=     E - Output to Excel
 ;                    R - Report
 ;          IBAPA   - 0 - List Insurance Plans by Insurance Company
 ;                    1 - List Insurance Plans by Insurance Company
 ;                        with Subscriber information
 ;          IBAPA   - 0 - List Insurance Plans by Insurance Company
 ;                    1 - List Insurance Plans by Insurance Company with Subscriber
 ;                        information
 ;          IBAPL   - 0 - User selected Group Plans
 ;                    1 - Run report for all Group Plans for each Ins. Co
 ;                    NOTE: only used if IBAI=1, otherwise, some Insurance
 ;                          companies may select all Group Plans and some 
 ;                          may be use selected Group Plans
 ;          ^TMP("IBINC",$J,IBIC,IBCNS,IBPTR)="" - Selected Ins Cos/Plans
 ;             Required if all Insurance Companies and all Group Plans
 ;             not selected Where:
 ;               IBIC   - Insurance Company Name
 ;               IBCNS  - IEN of the selected Insurance Company, file 36
 ;               IBPTR  - IEN of the selected Group Plan, file 355.3
 ;
 ; Compile report data
 N GIEN,XX
 S IBI=0
 K ^TMP($J,"PR"),^TMP($J,"PL")
 ;
 ; Display all Insurance Companies and all Group Plans
 I IBAI,IBAPL D
 . S IBIC1=""
 . F  S IBIC1=$O(^DIC(36,"B",IBIC1)) Q:IBIC1=""  D
 . . S IBCNS=0
 . . F  S IBCNS=$O(^DIC(36,"B",IBIC1,IBCNS)) Q:'IBCNS  D
 . . . I $D(^IBA(355.3,"B",IBCNS)) D
 . . . . S GIEN=$O(^IBA(355.3,"B",IBCNS,""))    ; Group Plan IEN, file 355.3
 . . . . ;
 . . . . ; Add Insurance Company/Group Plan to 'selected' list
 . . . . S ^TMP("IBINC",$J,IBIC1,IBCNS,GIEN)=""
 ;
 ; Display selected Insurance- user selected companies or plans
 S IBIC=""
 F  S IBIC=$O(^TMP("IBINC",$J,IBIC)) Q:IBIC=""  D
 . S IBCNS=0
 . F  S IBCNS=$O(^TMP("IBINC",$J,IBIC,IBCNS)) Q:'IBCNS  D GATH
 D PRINT
 Q
 ;
PRINT ; Print report
 D ^IBCOPP3
 K ^TMP($J,"PR"),^TMP("IBINC",$J)
 ;
 I $D(ZTQUEUED) S ZTREQ="@" Q
 D ^%ZISC
 K IBAI,IBAIA,IBAO,IBAIPA,IBAPA,IBAPL,IBCNS,IBCPS,IBCPT,IBCST,IBI,IBIC,IBIC1
 Q
 ;
GATH ; Gather all data for an Insurance Company.
 ; Input:   IBI         - Current Insurance Company Counter
 ;          IBIC        - Insurance Company Name
 ;          IBSNS       - IEN of the Insurance Company, file 36
 ;          ^TMP("IBINC",$J,IBIC,IBCNS,IBPTR) - See EN for detail
 ; Output:  IBI         - Updated Insurance Company Counter
 ;          ^TMP($J,"PR",IBI)=A1^A2^...^A11 Where:
 ;                             IBI  - Counter of # of Insurance Companies included
 ;                                    (starts at 1)
 ;                             A1   - Ins. Co. Name (1st 25 characters)
 ;                                    Leading '*' if inactive
 ;                             A2   - Street Address Line 1
 ;                             A3   - City, State Zip Code (up to 9 digits + dash)
 ;                             A4   - Timely Filing Timeframe
 ;                             A5   - # of total plans for the Insurance Company
 ;                             A6   - # of total subscribers per Insurance Company
 ;                             A7   - # of selected Plans per Insurance Company
 ;                             A8   - # of subscribers per selected plans
 ;                             A9   - Max length of Electronic Plan Type for Ins Co
 ;                             A10  - Max length of Plan Type for Ins Co
 ;                             A11  - Max length of Patient ID for Ins Co
 ;
 N IBCPS,IBCPT,IBCSS,IBCST,LENEP,LENPID,LENPT,XX
 S IBI=IBI+1,(IBCPT,IBCPS,IBCST,IBCSS)=0    ; Initialize counters
 S (LENEP,LENPID,LENPT)=0                   ; Init Max Elec Plan, Pat Id, Plan Type lengths
 D COMP(.LENPID)                            ; Gather company info
 D PLAN(.LENEP,.LENPT)                      ; Gather plan info
 ;
 ; Set final company info
 S XX=$$COMPINF(IBCNS)
 S XX=XX_"^"_IBCPT_"^"_IBCST_"^"_IBCPS_"^"_IBCSS_"^"_LENEP_"^"_LENPT_"^"_LENPID
 S ^TMP($J,"PR",IBI)=XX
 K ^TMP($J,"PL")
 Q
 ;
COMP(LENPID) ; Gather Company counts and subscription information, if necessary
 ; Input:   IBPA        - 0 - List Insurance Plans by Insurance Company
 ;                        1 - List Insurance Plans by Insurance Company
 ;                            with Subscriber information
 ;          IBAPL       - 0 - User selected Group Plans
 ;                        1 - All Group Plans selected
 ;          IBCNS       - IEN of the insurance company, file #36
 ;          ^TMP("IBINC",$J,IBIC,ICBNS)) - See EN for details
 ; Output:  LENPID      - Maximum length of Patient ID field for subscribers of
 ;                        this Insurance Company
 ;          IBCSS       - Total # of Subscribers in selected Group Plans
 ;          IBCST       - Total # of Subscribers
 ;          ^TMP($J,"PR",IBI,IBPTR,IBNAM_"@@"_DFN_"@@"_IBCDFN)=B1^B2^...^B10 Where
 ;                DFN   - IEN of the patient, file 2
 ;                IBCDFN- Insurance Company multiple
 ;                IBI   - Insurance counter
 ;                IBNAM - Patient's Name (B1)
 ;                IBPTR - IEN of the Group Plan, file 355.3
 ;                B1    - Patient's Name (1st 22 chars)
 ;                B2    - Last 4 Patient's SSN (with trailing 'P' if pseudo)
 ;                B3    - Patient's DOB (mm/dd/yy)
 ;                B4    - Subscriber ID (20 chars max)
 ;                B5    - Effective Date (mm/dd/yy)
 ;                B6    - Expiration Date (mm/dd/yy)
 ;                B7    - Whose Insurance (5 chars max)
 ;                B8    - Patient ID (30 chars max)
 ;  
 N DFN,IBCDFN,IBIND,IBNAM,IBPTR,IBX,PTLEN,VA,VAERR,VAOA,X,XX,Y
 S DFN=0
 F  S DFN=$O(^DPT("AB",IBCNS,DFN)) Q:'DFN  D
 . S IBCDFN=0
 . ;
 . ; NOTE: IBCDFN is the Insurance Company Multiple that contains the 
 . ;       Insurance company with an IEN of IBCNS
 . F  S IBCDFN=$O(^DPT("AB",IBCNS,DFN,IBCDFN)) Q:'IBCDFN  D
 . . ;
 . . ; Set company subscriber count; plan subscriber counts if necessary
 . . ; MRD;IB*2.0*516 - Use $$ZND^IBCNS1 to pull .312 zero node.
 . . ;S IBIND=$G(^DPT(DFN,.312,+IBCDFN,0)) Q:+IBIND'=IBCNS
 . . S IBIND=$$ZND^IBCNS1(DFN,+IBCDFN)
 . . Q:+IBIND'=IBCNS
 . . S IBPTR=+$P(IBIND,"^",18)              ; Group Plan IEN
 . . Q:'+IBPTR
 . . S IBCST=IBCST+1                        ; Update Total # of Subscribers
 . . ;
 . . ; Quit if not a selected Group Plan and All Group Plans were not selected
 . . I 'IBAPL,'$D(^TMP("IBINC",$J,IBIC,IBCNS,IBPTR)) Q
 . . S IBCSS=IBCSS+1                        ; Update Tot # of Selected Subscribers
 . . S ^TMP($J,"PL",IBPTR)=$G(^TMP($J,"PL",IBPTR))+1
 . . Q:'IBAPA                               ; Subscriber information not selected
 . . ;
 . . ; Gather Demographic/Policy information
 . . ; IB*2.0*549 - Changed fields retrieve for Subscriber Detail display
 . . S X=$$PT^IBEFUNC(DFN)
 . . S IBNAM=$E($P(X,"^",1),1,22)               ; Patient's Name (22 chars)
 . . S:IBNAM="" IBNAM="<Pt. "_DFN_" Name Missing>"
 . . S IBX=IBNAM
 . . ;
 . . ; Retrieve last 4 of SSN (last 5 if pseudo SSN)
 . . S XX=$$GET1^DIQ(2,DFN_",",.09,"I")         ; Patient's SSN
 . . S XX=$S($E(XX,$L(XX))="P":$E(XX,$L(XX)-4,$L(XX)),1:$E(XX,$L(XX)-3,$L(XX)))
 . . S $P(IBX,"^",2)=XX
 . . S XX=$$GET1^DIQ(2,DFN_",",.03,"I")         ; Patient's DOB
 . . S $P(IBX,"^",3)=$$FMTE^XLFDT(XX,"2DZ")
 . . S XX=$P(IBIND,"^",2),XX=$S(XX'="":XX,1:"<NO SUBS ID>")
 . . S $P(IBX,"^",4)=XX                         ; Subscriber ID (20 chars max)
 . . S XX=$$FMTE^XLFDT($P(IBIND,"^",8),"2DZ")   ; Effective Date
 . . S $P(IBX,"^",5)=XX
 . . S XX=$$FMTE^XLFDT($P(IBIND,"^",4),"2DZ")   ; Expiration Date
 . . S $P(IBX,"^",6)=XX
 . . ;
 . . ; Whose Insurance?
 . . S XX=$P(IBIND,"^",6),XX=$S(XX="v":"VET",XX="s":"SPO",XX="o":"OTH",1:"UNK")
 . . S $P(IBX,"^",7)=XX
 . . S XX=$$GET1^DIQ(2.312,IBCDFN_","_DFN_",",5.01,"I")  ; Patient ID
 . . S $P(IBX,"^",8)=XX
 . . S:LENPID<$L(XX) LENPID=$L(XX)
 . . S ^TMP($J,"PR",IBI,IBPTR,IBNAM_"@@"_DFN_"@@"_IBCDFN)=IBX
 Q
 ;
PLAN(LENEP,LENPT) ; Gather Group Insurance Plan information
 ; Input:   LENEP   - Current Maximum Electronic Plan length for Ins Co
 ;          LENPT   - Current Maximum Plan Type length for Ins Co
 ;          IBAPL   - 0 - User selected Group Plans
 ;                    1 - All Group Plans
 ;          IBCNS   - IEN of the Insurance Company, file #36
 ;          IBPTR   - IEN of the Group Insurance Plan, file 355.3
 ;          ^TMP("IBINC",$J,IBIC,ICBNS,IBPTR)) - See EN for details
 ;          ^TMP($J,"PL",IBPTR)                - Total # Subscribers for Group Plan
 ; Output:  LENEP   - Updated Maximum Electronic Plan length for Ins Co
 ;          LENPT   - Updated Maximum Plan Type length for Ins Co
 ;          IBCPS   - Total Number of Selected Group Plans for Ins. Co.
 ;          IBCPT   - Total # of Group Plans for Insurance Company
 ;          ^TMP($J,"PR",IBI,IBPTR)) - B1^B2^..^B6 where
 ;             IBI  - Counter of # of Insurance Companies included
 ;             IBPTR- Group Plan IEN
 ;             B1   - Group Number, field 355.3,2.02
 ;             B2   - Group Name, field 355.3,2.01
 ;             B3   - Group Plan Timely Filing Time frame (max len 21)
 ;             B4   - Electronic Plan Type (max length 26)
 ;             B5   - Type of Plan (max length 34)
 ;             B6   - Total # of subscribers for this Group Plan
 ;
 N IBPTR
 S IBPTR=0
 F  S IBPTR=$O(^IBA(355.3,"B",IBCNS,IBPTR)) Q:'IBPTR  D
 . S IBCPT=IBCPT+1                          ; Total # of Group Plans for Ins. Co.
 . ;
 . ; Quit if Group Plan was not selected by the user
 . I 'IBAPL,'$D(^TMP("IBINC",$J,IBIC,IBCNS,IBPTR)) Q
 . S IBCPS=IBCPS+1                          ; Total # of Selected Group Plans
 . S ^TMP($J,"PR",IBI,IBPTR)=$$PLANINF(IBPTR,.LENEP,.LENPT)_"^"_+$G(^TMP($J,"PL",IBPTR))
 Q
 ;
PLANINF(PLAN,LENEP,LENPT) ; Return formatted Group Insurance Plan information.
 ; Input:   PLAN    -  IEN of the Group Insurance Plan, file #355.3
 ;          LENEP   - Current Maximum Electronic Plan length for Ins Co
 ;          LENPT   - Current Maximum Plan Type length for Ins Co
 ; Output:  LENEP   - Updated Maximum Electronic Plan length for Ins Co
 ;          LENPT   - Updated Maximum Plan Type length for Ins Co
 ; Returns: A1^A2^A3^...^AN Where:
 ;            A1 - Group Plan Number
 ;            A2 - Group Plan Name (leading '*' if Inactive)
 ;            A3 - Group Plan Timely Filing Time frame (max len 21)
 ;            A4 - Electronic Plan Type (max length 26)
 ;            A5 - Type of Plan (max length 34)
 ;
 ; IB*2.0*549 Changed output to fields listed above
 N NAME,NUM,XX,ZZ
 S NUM=$$GET1^DIQ(355.3,PLAN,2.02)
 S:NUM="" NUM="<NO GROUP NUMBER>"
 S XX=$$GET1^DIQ(355.3,PLAN,.02,"I")        ; Group or Individual Plan
 S XX=$S(XX=1:"",1:"+")
 S ZZ=$$GET1^DIQ(355.3,PLAN,.11,"I")        ; Inactive Flag
 S ZZ=XX_$S(ZZ=1:"*",1:"")
 S $P(XX,"^",1)=ZZ_NUM                      ; Add Inactive/Individual flags
 S NAME=$$GET1^DIQ(355.3,PLAN,2.01)
 S:NAME="" NAME="<NO GROUP NAME>"
 S $P(XX,"^",2)=NAME                        ; Group Name
 S $P(XX,"^",3)=$$FTFGP^IBCNEUT7(PLAN)      ; Timely Filing Time Frame
 S ZZ=$$GET1^DIQ(355.3,PLAN_",",.15)        ; Electronic Plan Type
 S:$L(ZZ)>LENEP LENEP=$L(ZZ)                ; Maximum Electronic Plan length
 S $P(XX,"^",4)=ZZ
 S ZZ=$$GET1^DIQ(355.3,PLAN_",",.09)        ; Type of Plan
 S:$L(ZZ)>34 ZZ=$E(ZZ,1,34)
 S:$L(ZZ)>LENEP LENEP=$L(ZZ)                ; Maximum Plan Type length
 S $P(XX,"^",5)=ZZ
 Q XX
 ;
COMPINF(IBCNS) ; Return formatted Insurance Company information
 ; Input:   IBCNS   - IEN of the Insurance Company, file #36
 ; Output:  A1^A2^A3^A4 Where:
 ;           A1  - Insurance Company name (first 25 chars)
 ;                 with leading '*' if inactive
 ;           A2  - Street Address Line 1
 ;           A3  - City, ST ZIP
 ;           A4  - Timely Filing
 ;
 ; IB*2.0*549 Changed output to fields listed above
 N ST,X,X0,X11,XX,Z,ZZ
 S X0=$G(^DIC(36,IBCNS,0))
 S X11=$G(^DIC(36,IBCNS,.11))
 S Z=$P(X11,"^",6)
 S ST=$S($P(X11,"^",5):$P($G(^DIC(5,$P(X11,"^",5),0)),"^",2),1:"<STATE MISSING>")
 S XX=$S($P(X0,"^",5):"*",1:"")
 S X=XX_$E($P(X0,"^",1),1,25)
 S $P(X,"^",2)=$S($P(X11,"^",1)'="":$P(X11,"^",1),1:"<Street Addr. 1 Missing>")
 S $P(X,"^",3)=$P(X11,"^",4)_", "_ST_"  "_$E(Z,1,5)_$S($E(Z,6,9)]"":"-"_$E(Z,6,9),1:"")
 S $P(X,"^",4)=$$FTFIC^IBCNEUT7(IBCNS)
 Q X
