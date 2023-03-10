SD53P765 ;TMP/GN - TMP POST INSTALL FOR PATCH SD*5.3*765;July 30, 2018
 ;;5.3;Scheduling;**765**;May 29, 2018;Build 13
 ;
 ;Post install routine for SD*5.3*765 to load new Stop codes to the TMP file SD TELE HEALTH STOP CODE FILE #40.6.
 ;** this post install can be rerun with no harm, will report already on file if codes already there.
 ;
TMP28 ;Begin Post Install FOR TMP-28 ISSUE
 N ERRCNT,QQ,STP,STP1,STP2 S ERRCNT=0
 D MES^XPDUTL("")
 D MES^XPDUTL("Beginning update of SD TELE HEALTH STOP CODE FILE...")
 D MES^XPDUTL("") H 1
 F QQ=1:1 S STP=$P($T(STPCODES+QQ),";;",2) Q:STP=""  D
 .K DIE,FDA,SDIEN,TMPERR
 .I $O(^SD(40.6,"B",STP,"")) D MES^XPDUTL(STP_"    already on file") Q   ;skip already on file
 .I $L(STP)=3 D  Q
 ..I '$$CHKSTOP^SDTMPHLA(STP) D MES^XPDUTL(STP_"    ** Not added, invalid stop code") Q
 ..S FDA(40.6,"+1,",.01)=STP D UPDATE^DIE("","FDA","SDIEN","TMPERR") D:'$D(TMPERR) MES^XPDUTL(STP_"    added stop code")
 ..I $D(TMPERR) S ERRCNT=ERRCNT+1 D MES^XPDUTL(STP_" failed an attempt to add to the file.")
 .I $L(STP)=6 D  Q
 ..S STP1=$E(STP,1,3),STP2=$E(STP,4,6) I ('$$CHKSTOP^SDTMPHLA(STP1))!('$$CHKSTOP^SDTMPHLA(STP2)) D MES^XPDUTL(STP_" ** Not added, one or both stop codes in pair is invalid") Q
 ..S FDA(40.6,"+1,",.01)=STP D UPDATE^DIE("","FDA","SDIEN","TMPERR") D:'$D(TMPERR) MES^XPDUTL(STP_" added stop code pair")
 ..I $D(TMPERR) S ERRCNT=ERRCNT+1 D MES^XPDUTL(STP_" failed an attempt to add to the file.")
 .K DIE,FDA,SDIEN,TMPERR
 D MES^XPDUTL("")
 D MES^XPDUTL("Stop Code Update completed. "_ERRCNT_" error(s) found.")
 D MES^XPDUTL("")
 ;
 D POST^SDPAWS
 Q
STPCODES ;Add Clinic/Telephone stop codes not already on file (only if Valid stop codes on file 40.7 1st)
 ;;137;;Clinic stop codes begin
 ;;225
 ;;322
 ;;323531
 ;;440
 ;;444
 ;;445
 ;;446
 ;;447
 ;;644
 ;;645
 ;;646
 ;;647
 ;;679
 ;;718
 ;;723
 ;;724
 ;;103;;Telephone stop codes begin
 ;;103801
 ;;103802
 ;;103803
 ;;147
 ;;148
 ;;169
 ;;178
 ;;181
 ;;182
 ;;199
 ;;216
 ;;221
 ;;224
 ;;229
 ;;324
 ;;325
 ;;326
 ;;338
 ;;338531
 ;;424
 ;;425
 ;;428
 ;;441
 ;;527
 ;;528
 ;;530
 ;;536
 ;;542
 ;;545
 ;;546
 ;;579
 ;;584
 ;;597
 ;;611
 ;;686
