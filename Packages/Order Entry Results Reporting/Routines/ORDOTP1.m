ORDOTP1 ; SLC/TCK - OTP API FILER FOR #101.22   ; Oct 1, 2024@09:58:00
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**618**;Sep 19, 2024;Build 14
 ;
 ; Reference to ^DIE in ICR #2053
 Q
 ;
EN(DFN,DSTR) ;
 ;
 ; Called from ^TIUOTPF when opioid dispense data is received from a clinic
 ;
 ; Inputs
 ;  DFN - Patient ID
 ;  DSTR - Array containing fields to be entered into #101.22
 ;
 N FDA,I,IEN,IENS,OFDA
 K FDA,OFDA
 I 'DFN Q  ;Invalid patient
 ;Check if patient has dispense data in 101.22.  If not, add this patient to the file.
 I '$D(^ORD(101.22,"B",DFN)) S FDA(101.22,"?+1,",.01)=DFN D UPDATE^DIE("","FDA","","")
 S IEN="",IEN=$O(^ORD(101.22,"B",DFN,IEN)),IENS="+1,"_IEN_","
 Q:$G(DSTR)=""
 S OFDA(101.221,IENS,.01)=$P(DSTR,"^",1)
 F I=2:1:9 S OFDA(101.221,IENS,I)=$P(DSTR,"^",I)
 D UPDATE^DIE("","OFDA","","")
 Q
 ;
