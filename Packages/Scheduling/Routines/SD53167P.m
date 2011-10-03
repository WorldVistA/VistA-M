SD53167P ;ALB/JDS - Patch 218 postinit ; Nov 16 1998
 ;;5.3;Scheduling;**167**;AUG 13, 1993
 ;go through hopital location file printing clinics with '0' starttime
 N A,SCCNT,XPDIDTOT,SC D MES^XPDUTL("Searching for Clinics with HOUR CLINC DISPLAY BEGINS of '0'")
 S A="",SCCNT=0
 F   S A=$O(^SC("B",A)) Q:A=""  F SC=0:0 S SC=$O(^SC("B",A,SC)) Q:'SC  I $P($G(^SC(SC,"SL")),U,3)=0 D
 .D MES^XPDUTL($P($G(^SC(SC,0)),U)) S SCCNT=SCCNT+1
 I 'SCCNT D MES^XPDUTL("No clinics with HOUR CLINIC DISPLAY BEGINS of '0' found") Q
 D MES^XPDUTL(SCCNT_" Clinics Identified")
 D MES^XPDUTL("The beginning display time for these clinics will be midnight")
 D MES^XPDUTL("To maintain the current start time use the Set up a Clinic [SDBUILD] OPTION")
 D MES^XPDUTL("Select the Clinic")
 D MES^XPDUTL("Enter '^HOUR' and delete the HOUR CLINIC DISPLAY BEGINS value")
