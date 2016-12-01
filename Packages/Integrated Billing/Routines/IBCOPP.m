IBCOPP ;ALB/NLR - LIST INS. PLANS BY CO. (DRIVER) ; 20-OCT-2015
 ;;2.0;INTEGRATED BILLING;**28,62,528,549**;21-MAR-94;Build 54
 ;;Per VA Directive 6402, this routine should not be modified.
 ;
EN ; Describe report
 ; IB*2.0*549 - reworded report description
 W !!?5,"This report will generate a list of insurance plans by company."
 W !?5,"It will help you identify duplicates.  You must select one, many"
 W !?5,"or all of the insurance companies; anywhere from one to all of the"
 W !?5,"plans under each company; and whether to include the patient policies"
 W !?5,"(subscribers) under each plan.  The number of plans you select is "
 W !?5,"independent for each company you are including, but the subscriber"
 W !?5,"is the same (all or none) for all companies and plans within this report."
 W !?5,"Regardless of how you run the report, the number of group plans per"
 W !?5,"insurance company and the number of subscribers per plan will be"
 W !?5,"included.",!!
 ;
 ; Prompt user to select report type, insurance companies, plans
 ;
 ; Output from user selections:
 ;
 ; IBAO=   E - Output to Excel
 ;         R - Report
 ; IBAPA=  0 - List Insurance Plans by Insurance Company
 ;         1 - List Insurance Plans by Insurance Company with Subscriber
 ;             information
 ; IBAI=   0 - User selected Insurance Companies
 ;         1 - Run report for all Insurance Companies with Plans
 ; IBAIA=  0 - Only select Inactive Insurance Companies
 ;         1 - Only select Active Insurance Companies
 ;         2 - Select both Active and Inactive Insurance Companies
 ; IBAIPA= 0 - Only select Inactive Insurance Company Plans
 ;         1 - Only select Active Insurance Company Plans
 ;         2 - Select both Active and Inactive Insurance Company Plans
 ; IBAPL=  0 - Whether some or all ins. co's., user selects plans (may be
 ;             all for certain companies, some for other companies)
 ;         1 - Whether some or all ins. co's., run report for all plans
 ;             associated with those co's.
 ;
 N A,I,IBAO,POP,ZTDESC,ZTDEXC,ZTRTN,ZTSAVE,%ZIS
 K ^TMP("IBINC",$J)
 S IBAPA=$$SELR^IBCOPP1                     ; Report Type prompt
 I IBAPA<0 D ENQ Q
 S IBAI=$$SELI^IBCOPP1                      ; All/Selected Ins. Cos. prompt
 I IBAI<0 D ENQ Q
 ;
 ; IB*2.0*549 - Inactive/Active/Both Insurance Company look-up filter
 ;              Only ask if user didn't select all Insurance Companies
 S IBAIA=$$SELA^IBCOPP1
 I IBAIA<0 D ENQ Q
 ;
 ; IB*2.0*549 - Added call to Insurance Company look-up listman template
 ;              for selecting, moved from START method
 ; Allow user selection of Insurance Companies, if required
 I 'IBAI D  I IBQUIT=1 D ENQ Q
 . N IBCNS,XX
 . S IBQUIT=0
 . D EN^IBCNILK(IBAIA)
 . I '$D(^TMP("IBCNILKA",$J)) S IBQUIT=1 Q  ; No Insurance Companies selected
 . S IBCNS=""
 . F  S IBCNS=$O(^TMP("IBCNILKA",$J,IBCNS)) Q:IBCNS=""  D
 . . ;
 . . ; Insurance Company Name
 . . S XX=$E($$GET1^DIQ(36,IBCNS_",",.01),1,25)
 . . S ^TMP("IBINC",$J,XX,IBCNS)=""
 . K ^TMP("IBCNILKA",$J)
 ;
 S IBAPL=$$SELP^IBCOPP1                     ; Plan Selection prompt
 I IBAPL<0 D ENQ Q
 ;
 ; IB*2.0*549 - Inactive/Active/Both Insurance Company Plan look-up filter
 ;              Only ask if user didn't select all Group Plan
 S IBAIPA=2
 S:'IBAPL IBAIPA=$$SELPA^IBCOPP1
 I IBAIPA<0 D ENQ Q
 ;
 ; All Insurance Companies, All Plans, skip to device prompt
 I IBAI,IBAPL D  Q
 . S IBAO=$$OUT^IBCOPP1                     ; Report or CSV output
 . I IBAO<0 D ENQ Q
 . D DEVICE
 ;
 ; Obtain Plans for selected or All Insurance Companies
 D START
 I IBQUIT D ENQ Q
 I '$D(^TMP("IBINC",$J)) D  Q
 . W !!,*7,"No plans selected!"
 . D ENQ
 ;
 S IBAO=$$OUT^IBCOPP1                       ; Report or CSV output
 D DEVICE
 Q
 ;
DEVICE ; Ask user to select device
 ;
 N I,POP
 I IBAO'="E" D
 . W !!,"*** You will need a 132 column printer for this report. ***",!
 E  D
 . W !!,"For CSV output, turn logging or capture on now. To avoid undesired wrapping"
 . W !,"of the data saved to the file, please enter ""0;256;99999"" at the ""DEVICE:"""
 . W !,"prompt.",!
 S %ZIS="QM"
 D ^%ZIS
 I POP D ENQ Q
 I $D(IO("Q")) D  Q
 . S ZTRTN="^IBCOPP2",ZTDESC="IB - LIST OF PLANS BY INSURANCE COMPANY"
 . F I="^TMP(""IBINC"",$J,","IBAPA","IBAI","IBAPL","IBAO" S ZTSAVE(I)=""
 . D ^%ZTLOAD
 . K IO("Q")
 . D HOME^%ZIS
 . W !!,$S($D(ZTSK):"This job has been queued as task #"_ZTSK_".",1:"Unable to queue this job.")
 . K ZTSK,IO("Q")
 . D ENQ
 ;
 ; Compile and print report
 U IO
 D ^IBCOPP2
 ;
ENQ ;
 K A,DIRUT,DIROUT,DUOUT,DTOUT,IBAO,IBAI,IBAIA,IBAIPA,IBAPA,IBAPL,IBQUIT,X,Y
 K ^TMP("IBCNILKA",$J),^TMP("IBINC",$J)
 Q
 ;
START ; Gather plans for all selected companies.
 ; Input: IBAI  - 0 - User selected Insurance Companies
 ;                1 - Run report for all Insurance Companies with Plans
 ;        IBAIA - 0 - Only select Inactive Insurance Companies
 ;                1 - Only select Active Insurance Companies
 ;                2 - Select both Active and Inactive Insurance Companies
 ;        IBAIPA  0 - Only select Inactive Insurance Company Plans
 ;                1 - Only select Active Insurance Company Plans
 ;                2 - Select both Active and Inactive Insurance Company Plans
 ;        IBAPL - 0 - Whether some or all ins. co's., user selects plans (may be
 ;                    all for certain companies, some for other companies)
 ;                1 - Whether some or all ins. co's., run report for all plans
 ;                    associated with those co's.
 S (IBCT,IBQUIT)=0
 I IBAPL D STARTQ Q
 ;
 ; Gather all Insurance Companies if required
 I IBAI D
 . N INACT
 . S A=0
 . F  S A=$O(^IBA(355.3,"B",A)) Q:'A  D
 . . Q:$G(^DIC(36,A,0))=""
 . . S INACT=+$$GET1^DIQ(36,A_",",.05,"I")  ; Is the Insurance Company Inactive?
 . . I INACT,IBAIA=1 Q                      ; IB*2.0*549 Only include Active Ins. Cos.
 . . I 'INACT,IBAIA=0 Q                     ; IB*2.0*549 Only include Inactive Ins. Cos.
 . . S ^TMP("IBINC",$J,$E($P($G(^DIC(36,A,0)),"^"),1,25),A)=""
 ;
 ; Gather plans for selected Insurance Companies
 S IBIC=""
 F  S IBIC=$O(^TMP("IBINC",$J,IBIC)) Q:IBIC=""!IBQUIT  D
 . S IBCNS=""
 . F  S IBCNS=$O(^TMP("IBINC",$J,IBIC,IBCNS)) Q:IBCNS=""!(IBQUIT)  D
 . . S IBCT=IBCT+1
 . . W !!,"Insurance Company # "_IBCT_": "_IBIC
 . . D OK^IBCNSM3
 . . Q:IBQUIT
 . . I 'IBOK K ^TMP("IBINC",$J,IBIC,IBCNS) S IBAI=0 Q
 . . W "   ...building a list of plans..."
 . . K IBSEL,^TMP($J,"IBSEL")
 . . ;
 . . ; IB*2.0*549 - Add Active/Inactive/Both Plan filter
 . . S XX=$S(IBAIPA=0:2,IBAIPA=1:0,IBAIPA=2:1)
 . . D LKP^IBCNSU2(IBCNS,1,1,.IBSEL,0,XX)
 . . Q:IBQUIT
 . . I '$O(^TMP($J,"IBSEL",0)) D  Q
 . . . K ^TMP("IBINC",$J,IBIC,IBCNS)
 . . . S IBAI=0
 . . ;
 . . ; Set plans into an array
 . . S IBPN=0
 . . F  S IBPN=$O(^TMP($J,"IBSEL",IBPN)) Q:'IBPN  D
 . . . S ^TMP("IBINC",$J,IBIC,IBCNS,IBPN)=""
 ;
STARTQ ;
 K IBAO,IBCT,IBIC,IBJJ,IBLCT,IBCNS,IBOK,IBPN,IBSEL,^TMP($J,"IBSEL")
 Q 
