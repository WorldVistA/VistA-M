WV16PST ;HIOFO/FT-WV*1*16 POST INSTALLATION ROUTINE ;6/29/04  11:04
 ;;1.0;WOMEN'S HEALTH;**16**;Sep 30, 1998
 ;
 ; This routine uses the following IAs:
 ;  #1157 - ^XPDMENU        (supported)
 ;  #2916 - ^DDMOD          (supported)
 ; #10063 - ^%ZTLOAD        (supported)
 ; #10141 - ^XPDUTL         (supported)
 ;
EN ; Start the post-installation
 D EN1,EN2,EN3,EN4
 Q
EN1 ; Add/edit FILE 790.31 entries
 N WVERR,WVFDA,WVIEN
 I $O(^WV(790.31,"B","No Evidence of Malignancy",0))'>0 D  ;exists?
 .S WVFDA(790.31,"+1,",.01)="No Evidence of Malignancy"
 .S WVFDA(790.31,"+1,",.02)=90
 .S WVFDA(790.31,"+1,",.03)=$O(^WV(790.2,"B","MAMMOGRAM DX BILAT",0))
 .S WVFDA(790.31,"+1,",.04)=$O(^WV(790.2,"B","MAMMOGRAM DX UNILAT",0))
 .S WVFDA(790.31,"+1,",.05)=$O(^WV(790.2,"B","MAMMOGRAM SCREENING",0))
 .S WVFDA(790.31,"+1,",.06)=$O(^WV(790.2,"B","PAP SMEAR",0))
 .S WVFDA(790.31,"+1,",.07)=$O(^WV(790.2,"B","BREAST ULTRASOUND",0))
 .S WVFDA(790.31,"+1,",.2)=0
 .S WVFDA(790.31,"+1,",.21)=0
 .S WVIEN=""
 .D UPDATE^DIE("","WVFDA","WVIEN")
 .Q
 K WVDFA,WVIEN
 I $O(^WV(790.31,"B","Abnormal",0))'>0 D  ;exists?
 .S WVFDA(790.31,"+1,",.01)="Abnormal"
 .S WVFDA(790.31,"+1,",.02)=90
 .S WVFDA(790.31,"+1,",.03)=$O(^WV(790.2,"B","MAMMOGRAM DX BILAT",0))
 .S WVFDA(790.31,"+1,",.04)=$O(^WV(790.2,"B","MAMMOGRAM DX UNILAT",0))
 .S WVFDA(790.31,"+1,",.05)=$O(^WV(790.2,"B","MAMMOGRAM SCREENING",0))
 .S WVFDA(790.31,"+1,",.06)=$O(^WV(790.2,"B","PAP SMEAR",0))
 .S WVFDA(790.31,"+1,",.07)=$O(^WV(790.2,"B","BREAST ULTRASOUND",0))
 .S WVFDA(790.31,"+1,",.2)=0
 .S WVFDA(790.31,"+1,",.21)=1
 .S WVIEN=""
 .D UPDATE^DIE("","WVFDA","WVIEN")
 .Q
 ; Add 'BREAST ULTRASOUND' as an associated procedure to 'Unsatisfactory
 ; for Dx'.
 K WVFDA,WVIEN
 S WVIEN=$O(^WV(790.31,"B","Unsatisfactory for Dx",0))
 I WVIEN D
 .S WVFDA(790.31,WVIEN_",",.14)=$O(^WV(790.2,"B","BREAST ULTRASOUND",0))
 .D FILE^DIE("","WVFDA","WVERR")
 .Q
 Q
EN2 ; Option/menu changes
 ; Add WV PAP SMEAR SNOMED CODES to WV MENU-FILE MAINTENANCE menu.
 N WVFLAG,WVMENU,WVOPTION,WVORDER,WVSYN
 S WVMENU="WV MENU-FILE MAINTENANCE"
 S WVOPTION="WV PAP SMEAR SNOMED CODES",WVSYN="PAP",WVORDER=13
 S WVFLAG=$$ADD^XPDMENU(WVMENU,WVOPTION,WVSYN,WVORDER)
 Q
EN3 ; Create and populate AC index on FILE 790.1
 ; task job
 N WVMESAGE,ZTDESC,ZTDTH,ZTIO,ZTRTN,ZTSAVE,ZTSK
 S ZTRTN="Q4^WV16PST",ZTDESC="WV*1*16 INSTALLATION"
 S ZTIO="",ZTDTH=$H
 D ^%ZTLOAD
 S WVMESAGE="Will build new 'AC' x-ref on FILE 790.1 in background job #"_$G(ZTSK)
 D MES^XPDUTL(WVMESAGE)
 Q
Q4 ; Adding AC Index for WV PROCEDURE file (#790.1)
 I $D(ZTQUEUED) S ZTREQ="@"
 N MSG,RESULT,XREF
 S XREF("FILE")=790.1
 S XREF("ROOT FILE")=790.1
 S XREF("TYPE")="REGULAR"
 S XREF("SHORT DESCR")="Patient and Date of Procedure"
 S XREF("DESCR",1)="This index consists of patient DFN and date of procedure."
 S XREF("DESCR",2)="ex:  ^WV(790.1,'AC',DFN,Date of Procedure,DA)"
 S XREF("USE")="SORTING ONLY"
 S XREF("EXECUTION")="R"
 S XREF("ACTIVITY")="IR"
 S XREF("VAL",1)=.02
 S XREF("VAL",1,"SUBSCRIPT")=1
 S XREF("VAL",2)=.12
 S XREF("VAL",2,"SUBSCRIPT")=2
 S XREF("NAME")="AC"
 D CREIXN^DDMOD(.XREF,"S",.RESULT,"","MSG")
 Q
EN4 ; Add new purposes of notification to FILE 790.404
 N WVFDA,WVIEN,WVLETTER,WVLOOP,WVLOOP1,WVNAME,WVNODE
 D LETTER
 F WVLOOP=1:1 S WVNODE=$T(EN6A+WVLOOP) Q:$P(WVNODE,";",3)=""  D
 .S WVNAME=$P(WVNODE,";",3)
 .Q:WVNAME=""
 .Q:$D(^WV(790.404,"B",WVNAME))  ;already exists
 .K WVFDA
 .S WVFDA(790.404,"+1,",.01)=WVNAME
 .S WVFDA(790.404,"+1,",.04)=1       ;active: 1=yes
 .S WVFDA(790.404,"+1,",.02)=$P(WVNODE,";",4) ;priority code
 .S WVFDA(790.404,"+1,",.06)=$P(WVNODE,";",5) ;result/reminder type
 .S WVFDA(790.404,"+1,",.05)=$P(WVNODE,";",6) ;br or cx type
 .I $P(WVNODE,";",7)]"" D
 ..S WVFDA(790.404,"+1,",.07)=$$BRTXIEN^WVRPCPR1($P(WVNODE,";",7)) ;br tx need
 ..Q
 .I $P(WVNODE,";",8)]"" D
 ..S WVFDA(790.404,"+1,",.08)=$P(WVNODE,";",8) ;br tx due date
 ..Q
 .I $P(WVNODE,";",9)]"" D
 ..S WVFDA(790.404,"+1,",.09)=$$CXTXIEN^WVRPCPR1($P(WVNODE,";",9)) ;cx tx need
 ..Q
 .I $P(WVNODE,";",10)]"" D
 ..S WVFDA(790.404,"+1,",.1)=$P(WVNODE,";",10) ;cx tx due date
 ..Q
 .K WVIEN
 .D UPDATE^DIE("","WVFDA","WVIEN")
 .Q:+$G(WVLETTER(0))'>0  ;copy generic letter text for new purpose
 .S WVLOOP1=0
 .S ^WV(790.404,WVIEN(1),1,0)="^^"_WVLETTER(0)_U_WVLETTER(0)_U_DT
 .F WVLOOP1=1:1:WVLETTER(0) D
 ..S ^WV(790.404,WVIEN(1),1,WVLOOP1,0)=WVLETTER(WVLOOP1)
 ..Q
 .Q
 Q
 ;;(3)name;(4)priority;(5)result/reminder;(6)br/cx;(7)br tx need;(8)br tx due date;(9)cx tx need;(10)cx tx due date
EN6A ;New purposes of notification
 ;;CPRS UPDATE PAP TX NEED 4M;2;0;CX;;;Repeat PAP;4M
 ;;CPRS UPDATE PAP TX NEED 6M;2;0;CX;;;Repeat PAP;6M
 ;;CPRS UPDATE PAP TX NEED 3Y;3;0;CX;;;Routine PAP;3Y
 ;;CPRS UPDATE PAP TX NEED 2Y;3;0;CX;;;Routine PAP;2Y
 ;;CPRS UPDATE PAP TX NEED 1Y;3;0;CX;;;Routine PAP;1Y
 ;;CPRS UPDATE MAM TX NEED 1Y;3;0;BR;Mammogram, Screening;1Y;;
 ;;CPRS UPDATE MAM TX NEED 2Y;3;0;BR;Mammogram, Screening;2Y;;
 ;;CPRS UPDATE MAM TX NEED 6M;2;0;BR;Mammogram, Repeat;6M;;
 ;;CPRS UPDATE MAM TX NEED 4M;2;0;BR;Mammogram, Repeat;4M;;
 ;;MAM result NEM, next MAM 1Y;3;1;BR;Mammogram, Screening;1Y;;
 ;;MAM result NEM, next MAM 2Y;3;1;BR;Mammogram, Screening;2Y;;
 ;;MAM result NEM, next MAM 4M;2;1;BR;Mammogram, Repeat;4M;;
 ;;MAM result NEM, next MAM 6M;2;1;BR;Mammogram, Repeat;6M;;
 ;;MAM result abnormal, F/U MAM 4M;2;1;BR;Mammogram, Followup;4M;;
 ;;MAM result abnormal, F/U MAM 6M;2;1;BR;Mammogram, Followup;6M;;
 ;;PAP result NEM, next PAP 1Y;3;1;CX;;;Routine PAP;1Y
 ;;PAP result NEM, next PAP 2Y;3;1;CX;;;Routine PAP;2Y
 ;;PAP result NEM, next PAP 3Y;3;1;CX;;;Routine PAP;3Y
 ;;PAP result NEM, next PAP 4M;2;1;CX;;;Repeat PAP;4M
 ;;PAP result NEM, next PAP 6M;2;1;CX;;;Repeat PAP;6M
 ;;PAP result abnormal, F/U PAP 4M;2;1;CX;;;Follow-up PAP;4M
 ;;PAP result abnormal, F/U PAP 6M;2;1;CX;;;Follow-up PAP;6M
 ;;MAM unsatisfactory, need repeat;2;1;BR;Mammogram, Repeat;0D;;
 ;;Pap unsatisfactory, need repeat;2;1;CX;;;Repeat PAP;0D
 ;;PAP result NEM, further screening not required;3;1;CX;;;;
 ;;MAM result NEM, further screening not required;3;1;BR;;;;
 ;;;
 Q
LETTER ; Copy generic letter text into local array
 N WVCOUNT,WVLOOP,WVNODE
 K WVLETTER
 S (WVCOUNT,WVLOOP)=0
 F WVLOOP=1:1 S WVNODE=$T(LTRTEXT+WVLOOP) Q:$P(WVNODE,";",3)=""  D
 .S WVCOUNT=WVCOUNT+1
 .S WVLETTER(WVCOUNT)=$P(WVNODE,";",3)
 .Q
 S WVLETTER(0)=WVCOUNT
 Q
LTRTEXT ;;Generic letter text
 ;;|NOWRAP|;
 ;; ;
 ;;|CENTER("Women's Health Clinic")|;
 ;; ;
 ;;|CENTER("Your Street")|;
 ;; ;
 ;;|CENTER("Your City, ST  Zip Code")|;
 ;; ;
 ;; ;
 ;;     |TODAY|;
 ;; ;
 ;; ;
 ;;                                                       |$E(SSN#,6,9)|;
 ;;     |$P(NAME,",",2)| |$P(NAME,",")|;
 ;;     |COMPLETE ADDRESS|;
 ;; ;
 ;; ;
 ;; ;
 ;; ;
 ;; ;
 ;;- -                                                                    - -;
 ;; ;
 ;;     Dear Ms. |$P(NAME,",",1)|,;
 ;; ;
 ;;     This is the body of the letter and should be edited to say what;
 ;;     you want for this Purpose of Notification.;
 ;; ;
 ;; ;
 ;;     Sincerely,;
 ;; ;
 ;; ;
 ;; ;
 ;;     Your Name;
 ;;     Women's Health Program;
 ;;     phone: nnn-nnnn;
 ;; ;
 ;; ;
 ;;     printed: |NOW|;
 ;;;
