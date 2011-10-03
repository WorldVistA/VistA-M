SDPPAT1 ;ALB/CAW-Patient Profile (Generic Patient Info) Screen 1;5/4/92
 ;;5.3;Scheduling;**6,140,441**;Aug 13, 1993;Build 14
 ;
 ;
PDATA ; Patient Data
 N SD,SDELIG,SDDIS,SDCNT,CNT,SDCT,SDCOPS
 F SD=0,.3,.11,.121,.122,.13,.32,.321,.35,.36,.52,"TYPE","VET" S SD(SD)=$G(^DPT(DFN,SD))
 I $D(^DPT(DFN,.372,0)) S SDDIS=0 F  S SDDIS=$O(^DPT(DFN,.372,SDDIS)) Q:'SDDIS  D
 .S SDDIS(SDDIS)=$G(^DPT(DFN,.372,SDDIS,0))
 .S SDDIS(SDDIS)=$P($G(^DIC(31,+$P(SDDIS(SDDIS),U),0)),U)_" ("_$S($P(SDDIS(SDDIS),U,3):"SC-",1:"NSC-")_$P(SDDIS(SDDIS),U,2)_"%)"
 .S SDCNT(SDDIS)=$L($P(SDDIS(SDDIS),U))+2
 S SDELIG=0 F  S SDELIG=$O(^DPT(DFN,"E",SDELIG)) Q:'SDELIG  S:SDELIG'=+SD(.36) SDELIG(SDELIG)=$G(^DPT(DFN,"E",SDELIG,0))
 S SD("MT")=$$LST^DGMTU(DFN) I 'SD("MT") S SDCOPS=$$LST^DGMTU(DFN,"",2)
 S SDFSTCOL=22,SDSECCOL=60
PTDOB ; Date of Birth and Marital Status Info
 ;
 S X="",X=$$SETSTR^VALM1("Date of Birth:",X,7,14)
 S X=$$SETSTR^VALM1($$FTIME^VALM1($P(SD(0),U,3)),X,SDFSTCOL,18)
 S X=$$SETSTR^VALM1("Marital Status:",X,44,15)
 S X=$$SETSTR^VALM1($P($G(^DIC(11,+$P(SD(0),U,5),0)),U),X,SDSECCOL,20)
 D SET(X)
PTSEX ; Sex and Religions Pref. Info
 ;
 S X="",X=$$SETSTR^VALM1("Sex:",X,17,4)
 S X=$$SETSTR^VALM1($S($P(SD(0),U,2)="F":"FEMALE",$P(SD(0),U,2)="M":"MALE",1:"UNKNOWN"),X,SDFSTCOL,18)
 S X=$$SETSTR^VALM1("Religious Pref.:",X,43,16)
 S X=$$SETSTR^VALM1($P($G(^DIC(13,+$P(SD(0),U,8),0)),U),X,SDSECCOL,20)
 D SET(X)
PTRACE ; SSN and Occupation Info
 ;
 S X="",X=$$SETSTR^VALM1("Patient ID:",X,10,11)
 S X=$$SETSTR^VALM1(VA("PID"),X,SDFSTCOL,20)
 S X=$$SETSTR^VALM1("Occupation:",X,48,11)
 S X=$$SETSTR^VALM1($P(SD(0),U,7),X,SDSECCOL,20)
 D SET(X)
PWHO ; Who entered and Place of Birth
 ;
 S X="",X=$$SETSTR^VALM1("Who entered:",X,9,12)
 S X=$$SETSTR^VALM1($P($G(^VA(200,+$P(SD(0),U,15),0)),U),X,SDFSTCOL,20)
 S X=$$SETSTR^VALM1("Place of Birth:",X,44,15)
 S X=$$SETSTR^VALM1(($P(SD(0),U,11)_$S($P(SD(0),U,12):", ",1:"")_$P($G(^DIC(5,+$P(SD(0),U,12),0)),U)),X,SDSECCOL,20)
 D SET(X)
PWHEN ; Date entered
 S X="",X=$$SETSTR^VALM1("Date entered:",X,8,13)
 S X=$$SETSTR^VALM1($S($P(SD(0),U,16):$TR($$FMTE^XLFDT($P(SD(0),U,16),"5DF")," ","0"),1:""),X,SDFSTCOL,20)
 D SET(X)
MT ; Current Means Test - if applicable
 ;
 S X="" I SD("MT")'="" D
 .S X=$$SETSTR^VALM1("Current Means Test:",X,2,19)
 .S X=$$SETSTR^VALM1($P(SD("MT"),U,3),X,SDFSTCOL,30)
 .S X=$$SETSTR^VALM1("Date Means Test:",X,43,16)
 .S X=$$SETSTR^VALM1($TR($$FMTE^XLFDT($P(SD("MT"),U,2),"5DF")," ","0"),X,SDSECCOL,20)
 I $D(SDCOPS),+SDCOPS D
 .S X=$$SETSTR^VALM1("Current Co-Pay Test:",X,1,20)
 .S X=$$SETSTR^VALM1($P(SDCOPS,U,3),X,SDFSTCOL,30)
 .S X=$$SETSTR^VALM1("Date Co-Pay Test:",X,42,17)
 .S X=$$SETSTR^VALM1($TR($$FMTE^XLFDT($P(SDCOPS,U,2),"5DF")," ","0"),X,SDSECCOL,20)
 D SET(X)
REMARK ; Remark
 S X="" I $P(SD(0),U,10)'="" D
 .S X=$$SETSTR^VALM1("Remarks:",X,13,8)
 .S X=$$SETSTR^VALM1($P(SD(0),U,10),X,SDFSTCOL,60)
 D SET(X)
PRIME ; Primary Eligibility
 ;
 S X="",X=$$SETSTR^VALM1("Primary Eligibility:",X,1,20)
 S X=$$SETSTR^VALM1($$FELIG(SD(.36)),X,SDFSTCOL,30)
 D SET(X)
OTHERE ; Other Eligibilities and Date of Death
 ;
 S X="",X=$$SETSTR^VALM1("Other Eligibilities:",X,1,20)
 I $P(SD(.35),U)'="" S X=$$SETSTR^VALM1("Date of Death:",X,45,14),X=$$SETSTR^VALM1($TR($$FMTE^XLFDT($P(SD(.35),U),"5DF")," ","0"),X,SDSECCOL,20)
 D SET(X)
VET ; List of other eligibilities and VETERAN(Y/N)
 S SDELIG=0 F  S SDELIG=$O(SDELIG(SDELIG)) Q:'SDELIG  S SDCT=$G(SDCT)+1,ROU=$S(SDCT=1:"OTH1",SDCT=2:"OTH2",1:"OTHM") D @ROU I SDCT=5 S X="",X=$$SETSTR^VALM1("(this patient has more 'other eligibilities that are not listed)",X,10,65) D SET(X) Q
 I '$D(SDCT) D
 .S X="",X=$$SETSTR^VALM1("VETERAN(Y/N):",X,46,13)
 .S X=$$SETSTR^VALM1($S(SD("VET")="N":"NO",SD("VET")="Y":"YES",1:"UNKNOWN"),X,SDSECCOL,7)
 .D SET(X)
 .S X="",X=$$SETSTR^VALM1("Type:",X,54,5)
 .S X=$$SETSTR^VALM1($P($G(^DG(391,+SD("TYPE"),0)),U),X,SDSECCOL,20)
 .D SET(X)
 F SD=SDLN:1:12 D SET("")
 D ^SDPPAT2
 S VALMCNT=SDLN
 Q
SET(X) ; Set in ^TMP global for display
 ;
 S SDLN=$G(SDLN)+1,^TMP("SDPP",$J,SDLN,0)=X
 Q
OTH1 ; First 'Other' Eligibility' and VETERAN(Y/N)
 S X="",X=$$SETSTR^VALM1($$FELIG(SDELIG(SDELIG)),X,10,30)
 S X=$$SETSTR^VALM1("VETERAN(Y/N):",X,46,13)
 S X=$$SETSTR^VALM1($S(SD("VET")="N":"NO",SD("VET")="Y":"YES",1:"UNKNOWN"),X,SDSECCOL,7)
 D SET(X)
 Q
OTH2 ; Second 'Other Eligbility' and TYPE
 S X="",X=$$SETSTR^VALM1($$FELIG(SDELIG(SDELIG)),X,10,30)
 S X=$$SETSTR^VALM1("Type:",X,53,5)
 S X=$$SETSTR^VALM1($P($G(^DG(391,+SD("TYPE"),0)),U),X,SDSECCOL,20)
 D SET(X)
 Q
OTHM ; Rest of 'Other Eligibilities'
 Q:SDCT>4
 S X="",X=$$SETSTR^VALM1($$FELIG(SDELIG(SDELIG)),X,10,30)
 D SET(X)
 Q
FELIG(ELIG) ;
 ;  input - pointer to eligibility file
 ; output - name of eligibility
 Q $P($G(^DIC(8,+ELIG,0)),U)
