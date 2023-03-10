DGRPD1 ;BPFO/JRC,BAJ,DJE,ARF,JAM,ARF - PATIENT INQUIRY (NEW) ;Sep 28, 2017  5:35PM
 ;;5.3;Registration;**703,730,688,863,935,985,997,1067**;Aug 13, 1993;Build 23
 ; DG*5.3*688 BAJ
 ; tags HDR & OKLINE moved as is from DGRPD for size considerations
 Q
EC ;display emergency contact information
 N DGEC1,DGEC2
 ; DG*5.3*997;jam; new variables for displaying foreign addresses
 N DGCNTRY1,DGCNTRY2,DGFOR1,DGFOR2
 Q:'$G(DFN)
 S VAOA("A")=1,VAROOT="DGEC1"  D OAD^VADPT ; Get Primary EC
 S VAOA("A")=4,VAROOT="DGEC2"  D OAD^VADPT ; Get Secondary EC
 I DGEC1(9)]"" D
 . W !,"Emergency Contact Information:"
 . ;Contacts name and realtionship
 . W !?6,"E-Cont.: ",DGEC1(9)
 . I DGEC2(9)]"" W ?46,"E2-Cont.: ",DGEC2(9)
 . ;DG*5.3*1067 begin - Added RELATION TYPE field and moved
 . ;RELATIONSHIP TO PATIENT under the RELATION TYPE.
 . ;Changed its label to from RELATIONSHIP TO PATIENT to RELATION NOTE
 . W:((DGEC1(12)'="")!(DGEC2(12)'="")!(DGEC1(10)'="")!(DGEC2(10)'="")) !  ;RELATION TYPE is in node 10-RELATIONSHIP TO PATIENT is in node 12
 . W:DGEC1(10)]'"" "Relation Type: ",$E(DGEC1(10),1,25)
 . W:DGEC2(10)]'"" ?41,"Relation Type: ",DGEC2(10)
 . W:((DGEC1(12)'="")!(DGEC2(12)'="")) !
 . I DGEC1(10)]"" W "Relation Note: ",DGEC1(12)
 . I DGEC2(10)]"" W ?41,"Relation Note: ",DGEC2(12)
 . ;DG*5.3*1067 end
 . ;ECs address lines 1, 2 and 3
 . I DGEC1(1)]"" W !?14,DGEC1(1)
 . I DGEC1(1)']"",DGEC2(1)]"" W !
 . I DGEC2(1)]"" W ?50,DGEC2(1)
 . I DGEC1(2)]"" W !?14,DGEC1(2)
 . I DGEC1(2)']"",DGEC2(2)]"" W !
 . I DGEC2(2)]"" W ?50,DGEC2(2)
 . I DGEC1(3)]"" W !?14,DGEC1(3)
 . I DGEC1(3)']"",DGEC2(3)]"" W !
 . I DGEC2(3)]"" W ?50,DGEC2(3)
 . ; DG*5.3*997;jam; allow for Foreign addresses
 . ; - get the EC Countries and flags for foreign address
 . S DGCNTRY1=$$GET1^DIQ(2,DFN_",",.3306,"I")
 . S DGCNTRY2=$$GET1^DIQ(2,DFN_",",.331012,"I")
 . S DGFOR1=$$FORIEN^DGADDUTL(DGCNTRY1) I DGFOR1=-1 S DGFOR1=1
 . S DGFOR2=$$FORIEN^DGADDUTL(DGCNTRY2) I DGFOR2=-1 S DGFOR2=1
 . S DGCNTRY1=$$CNTRYI^DGADDUTL(DGCNTRY1)
 . S DGCNTRY2=$$CNTRYI^DGADDUTL(DGCNTRY2)
 . ;Emergency Contact 1 City, State an Zip+4
 . I DGEC1(4)]"" D
 . . W !?14,DGEC1(4)
 . . ; DG*5.3*997;jam; check for EC1 foreign address. If foreign, Province and Postal Code follow the city
 . . I 'DGFOR1 D
 . . . I DGEC1(5)]"" W ", "_$$GET1^DIQ(5,+DGEC1(5),1)
 . . . W "  ",$P(DGEC1(11),"^",2)
 . . I DGFOR1 D
 . . . W " "_$$GET1^DIQ(2,DFN_",",.3307)_" "_$$GET1^DIQ(2,DFN_",",.3308)
 . ;Emergency Contact 2 City State and Zip+4
 . I DGEC2(4)]"" D
 . . I DGEC1(4)']"" W !
 . . W ?50,DGEC2(4)
 . . ; DG*5.3*997;jam; check for EC2 foreign address. If foreign, Province and Postal Code follow the city
 . . I 'DGFOR2 D
 . . . I DGEC2(5)]"" W ", "_$$GET1^DIQ(5,+DGEC2(5),1)
 . . . W "  ",$P(DGEC2(11),"^",2)
 . . I DGFOR2 D
 . . . W " "_$$GET1^DIQ(2,DFN_",",.331013)_" "_$$GET1^DIQ(2,DFN_",",.331014)
 . ; DG*5.3*997;jam; ECs Country
 . I DGCNTRY1]"" W !?14,$E(DGCNTRY1,1,30)
 . I DGCNTRY1']"" W !
 . W ?50,$E(DGCNTRY2,1,30)
 . ;Home and work phones
 . W !,?7,"Phone: ",$S(DGEC1(8)]"":DGEC1(8),1:"UNSPECIFIED")
 . I DGEC2(9)]"" W ?43,"Phone: ",$S(DGEC2(8)]"":DGEC2(8),1:"UNSPECIFIED")
 . W !?2,"Work Phone: ",$S($P(^DPT(DFN,.33),U,11)]"":$P(^DPT(DFN,.33),U,11),1:"UNSPECIFIED")
 . I DGEC2(9)]"" W ?38,"Work Phone: ",$S($P(^DPT(DFN,.331),U,11)]"":$P(^DPT(DFN,.331),U,11),1:"UNSPECIFIED")
 D KVAR^VADPT
 Q
 ;
CATDIS ;
 ;displays catastrophic disabity review date if there is one
 N DGCDIS
 Q:'$G(DFN)
 I $$GET^DGENCDA(DFN,.DGCDIS) D
 .Q:'DGCDIS("REVDTE")
 .W !!,"Catastrophically Disabled Review Date: ",$$FMTE^XLFDT(DGCDIS("REVDTE"),1)
 Q
HDR I '$D(IOF) S IOP="HOME" D ^%ZIS K IOP
 ;MPI/PD CHANGE
 ;DJE DG*5.3*935 - Add Member ID To Vista Registration Banner - RM#879322 (added SSNNM call)
 ;ARF DG*5.3*985 - Add Preferred Name to Patient Inquiry banner
 N X,DGLN,DGSSNNM,DGSSNNM1,DGPRFNAM,DGSSN,DGEPI,DGNAME,DGDOB,DGCNT,DGLINE,DIWL,DIWR,DIWF
 ;W @IOF,!,$$SSNNM^DGRPU(DFN),?65,$P(VADM(3),"^",2) S X="",$P(X,"=",78)="" W !,X,! Q  ;**863 - MVI_2351 (ptd)
 ;END MPI/PD CHANGE
 ;ARF DG*5.3*985 - replace previous code for the banner with logic to pull out individual fields to place them in proper order
 S DGPRFNAM=$$GET1^DIQ(2,+DFN_",",.2405,"E")
 S:DGPRFNAM'="" DGPRFNAM="("_DGPRFNAM_")"
 S DGSSNNM=$$SSNNM^DGRPU(DFN)
 S DGNAME=$P(DGSSNNM,";",1)_";"
 S DGSSNNM1=$P(DGSSNNM,";",2)
 S DGSSN=$P(DGSSNNM1," ",3)
 S DGEPI=$S($P(DGSSNNM1," ",2)'="":" "_$P(DGSSNNM1," ",2),1:"")
 S DGDOB=$P(VADM(3),"^",2)
 S DGDOB=$TR(DGDOB," ","_")  ;replaced space in DGDOB with "_" for the ^DIWP utility
 ;ARF DG*5.3*985 - create the string of fields for the banner
 S X=DGNAME_DGPRFNAM_DGEPI_" "_DGSSN_" "_DGDOB
 W @IOF,!
 ;ARF DG*5.3*985 - use ^DIWP to insure proper wrapping if string goes beyond 80 chars
 K ^UTILITY($J,"W") S DIWL=0,DIWR=79,DIWF="" D ^DIWP
 S DGCNT=^UTILITY($J,"W",0)
 F DGLN=1:1:DGCNT S DGLINE=$TR(^UTILITY($J,"W",0,DGLN,0),"_"," ") W !,DGLINE  ;replaced "_" for display
 S X="",$P(X,"=",78)="" W !,X,!
 K ^UTILITY($J,"W")
OKLINE(DGLINE) ;DOES PAUSE/HEADER IF $Y EXCEEDS DGLINE
 ;
 ;IN:   DGLINE --MAX LINE COUNT W/O PAUSE
 ;OUT:  DGLINE[RETURNED] -- 0 IF TIMEOUT/UP ARROW
 ;      DGRPOUT[SET]     -- 1 IF "
 N X,Y  ;**286** MLR 09/25/00  Newing X & Y variables prior to ^DIR
 I $G(IOST)["P-" Q DGLINE ; if printer, quit
 I $Y>DGLINE N DIR S DIR(0)="E" D ^DIR D:Y HDR I 'Y S DGRPOUT=1,DGLINE=0
 Q DGLINE
 ;
