ACKQDWLR ;HCIOFO/BH-Print A&SP Capitation Report ; [ 06/06/99   10:45 AM ]
 ;;3.0;QUASAR;**1**;Feb 11, 2000
 ;
 ;Per VHA Directive 10-93-142, this routine SHOULD NOT be modified.
 ;
 ;
SUMZIP ;  Display summary of ZIP data
 Q:'$D(^TMP("ACKQDWLP",$J,"S",3))
 ;
 N ACKF,ACKZSCTA,ACKZSTTA,ACKZSUTA,ACKZSPTA,ACKDD,ACKZC
 N ACKSTR,ACKZSCTS,ACKZSTTS,ACKZSUTS,ACKZSPTS,ACKTYPE
 S (ACKZSCTA,ACKZSTTA,ACKZSUTA,ACKZSPTA,ACKZSCTS,ACKZSTTS,ACKZSUTS,ACKZSPTS)=0
 S AS="",ACKTYPE="ZIP"
 ;  Display Heading and sub heading
 D HEADER,ZIPHD
 ;
 F  S AS=$O(^TMP("ACKQDWLP",$J,"S",3,AS)) Q:AS=""!($D(DIRUT))  D
 .I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ZIPHD
 .S XAS=$S(AS="A":"Audiology",1:"Speech Pathology")
 .W !," "_XAS,":"
 .S (ACKZC,ACKSTR)=""
 .F  S ACKZC=$O(^TMP("ACKQDWLP",$J,"S",3,AS,ACKZC)) Q:ACKZC=""!($D(DIRUT))  D
 ..I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ZIPHD W !," "_XAS,":"
 ..S ACKF=1,ACKDD=""
 ..F  S ACKDD=$O(^TMP("ACKQDWLP",$J,"S",3,AS,ACKZC,ACKDD)) Q:ACKDD=""!($D(DIRUT))  D
 ...S ACKSTR=^TMP("ACKQDWLP",$J,"S",3,AS,ACKZC,ACKDD)
 ...;  Print Zip data
 ...W !
 ...I ACKF W " "_ACKZC S ACKF=0
 ...W ?9,$P(ACKDIV(ACKDD),U,3)
 ...W ?32,$S($P(ACKSTR,U,1):$P(ACKSTR,U,1),1:"0")
 ...W ?45,$S($P(ACKSTR,U,2):$P(ACKSTR,U,2),1:"0")
 ...W ?59,$S($P(ACKSTR,U,3):$P(ACKSTR,U,3),1:"0")
 ...W ?72,$S($P(ACKSTR,U,4):$P(ACKSTR,U,4),1:"0")
 ...;
 ...;  Calculate Totals
 ...S @("ACKZSCT"_AS)=@("ACKZSCT"_AS)+$P(ACKSTR,U,1)
 ...S @("ACKZSTT"_AS)=@("ACKZSTT"_AS)+$P(ACKSTR,U,2)
 ...S @("ACKZSUT"_AS)=@("ACKZSUT"_AS)+$P(ACKSTR,U,3)
 ...S @("ACKZSPT"_AS)=@("ACKZSPT"_AS)+$P(ACKSTR,U,4)
 ..;
 ..Q:$D(DIRUT)
 .Q:$D(DIRUT)
 .S $P(LN,"-",80)="" W !,LN
 .W !," "_XAS," Total: ",?32,@("ACKZSCT"_AS),?45,@("ACKZSTT"_AS)
 .W ?59,@("ACKZSUT"_AS),?72,@("ACKZSPT"_AS),!
 ;
 Q:$D(DIRUT)
 ;  Calculate and Display Grand Total for ZIP
 N ACKGT1,ACKGT2,ACKGT3,ACKGT4
 S ACKGT1=$G(ACKZSCTS)+$G(ACKZSCTA)
 S ACKGT2=$G(ACKZSTTS)+$G(ACKZSTTA)
 S ACKGT3=$G(ACKZSUTS)+$G(ACKZSUTA)
 S ACKGT4=$G(ACKZSPTS)+$G(ACKZSPTA)
 I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ZIPHD W !," "_XAS,":"
 W !," Grand Total",?32,ACKGT1,?45,ACKGT2,?59,ACKGT3,?72,ACKGT4,!
 D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 ;
 Q
 ;
SUMICD ;  Display summary of ICD data
 Q:'$D(^TMP("ACKQDWLP",$J,"S",1))
 ;
 N ACKF,ACKISCTA,ACKISTTA,ACKISUTA,ACKDD,ACKIC
 N ACKSTR,ACKISCTS,ACKISTTS,ACKISUTS,ACKTYPE
 S (ACKISCTA,ACKISTTA,ACKISUTA,ACKISCTS,ACKISTTS,ACKISUTS)=0
 S ACKTYPE="ICD"
 ;  Display main heading and sub heading
 D HEADER,ICDCPTHD
 ;
 S AS=""
 F  S AS=$O(^TMP("ACKQDWLP",$J,"S",1,AS)) Q:AS=""!($D(DIRUT))  D
 . I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ICDCPTHD
 . S XAS=$S(AS="A":"Audiology",1:"Speech Pathology")
 . W !," "_XAS,":"
 . S (ACKIC,ACKSTR)=""
 . F  S ACKIC=$O(^TMP("ACKQDWLP",$J,"S",1,AS,ACKIC)) Q:ACKIC=""!($D(DIRUT))  D
 .. I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ICDCPTHD W !," "_XAS,":"
 .. S ACKF=1,ACKDD=""
 .. F  S ACKDD=$O(^TMP("ACKQDWLP",$J,"S",1,AS,ACKIC,ACKDD)) Q:ACKDD=""!($D(DIRUT))  D
 ... S ACKSTR=^TMP("ACKQDWLP",$J,"S",1,AS,ACKIC,ACKDD)
 ...;  Print ICD data
 ... W !
 ... I ACKF W " "_ACKIC S ACKF=0
 ... W ?9,$P(ACKDIV(ACKDD),U,3)
 ... W ?32,$S($P(ACKSTR,U,1):$P(ACKSTR,U,1),1:"0")
 ... W ?45,$S($P(ACKSTR,U,2):$P(ACKSTR,U,2),1:"0")
 ... W ?59,$S($P(ACKSTR,U,3):$P(ACKSTR,U,3),1:"0")
 ...;
 ...;  Calculate Totals
 ... S @("ACKISCT"_AS)=@("ACKISCT"_AS)+$P(ACKSTR,U,1)
 ... S @("ACKISTT"_AS)=@("ACKISTT"_AS)+$P(ACKSTR,U,2)
 ... S @("ACKISUT"_AS)=@("ACKISUT"_AS)+$P(ACKSTR,U,3)
 ..;
 .. Q:$D(DIRUT)
 . Q:$D(DIRUT)
 . S $P(LN,"-",80)="" W !,LN
 . W !," "_XAS," Total: ",?32,@("ACKISCT"_AS),?45,@("ACKISTT"_AS)
 . W ?59,@("ACKISUT"_AS),!
 ;
 Q:$D(DIRUT)
 ;  Calculate and Display Grand Total for ZIP
 N ACKGT1,ACKGT2,ACKGT3
 S ACKGT1=$G(ACKISCTS)+$G(ACKISCTA)
 S ACKGT2=$G(ACKISTTS)+$G(ACKISTTA)
 S ACKGT3=$G(ACKISUTS)+$G(ACKISUTA)
 ;
 I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ICDCPTHD W !," "_XAS,":"
 W !," Grand Total",?32,ACKGT1,?45,ACKGT2,?59,ACKGT3,!
 D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 ;
 Q
 ;
SUMCPT ;  Display summary of CPT data
 Q:'$D(^TMP("ACKQDWLP",$J,"S",2))
 ;
 N ACKF,ACKCSCTA,ACKCSTTA,ACKCSUTA,ACKDD,ACKCC
 N ACKSTR,ACKCSCTS,ACKCSTTS,ACKCSUTS,ACKTYPE
 S (ACKCSCTA,ACKCSTTA,ACKCSUTA,ACKCSCTS,ACKCSTTS,ACKCSUTS)=0
 S ACKTYPE="CPT"
 ;  Display main heading and sub heading
 D HEADER,ICDCPTHD
 ;
 S AS=""
 F  S AS=$O(^TMP("ACKQDWLP",$J,"S",2,AS)) Q:AS=""!($D(DIRUT))  D
 . I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ICDCPTHD
 . S XAS=$S(AS="A":"Audiology",1:"Speech Pathology")
 . W !," "_XAS,":"
 . S (ACKCC,ACKSTR)=""
 .;
 . F  S ACKCC=$O(^TMP("ACKQDWLP",$J,"S",2,AS,ACKCC)) Q:ACKCC=""!($D(DIRUT))  D
 .. I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ICDCPTHD W " "_XAS,":"
 .. S ACKF=1,ACKDD=""
 .. F  S ACKDD=$O(^TMP("ACKQDWLP",$J,"S",2,AS,ACKCC,ACKDD))  Q:ACKDD=""!($D(DIRUT))  D
 ... S ACKSTR=^TMP("ACKQDWLP",$J,"S",2,AS,ACKCC,ACKDD)
 ...;  Print Zip data
 ... W !
 ... I ACKF W " "_$$GET1^DIQ(509850.4,ACKCC_",",.01) S ACKF=0
 ... W ?9,$P(ACKDIV(ACKDD),U,3)
 ... W ?32,$S($P(ACKSTR,U,1):$P(ACKSTR,U,1),1:"0")
 ... W ?45,$S($P(ACKSTR,U,2):$P(ACKSTR,U,2),1:"0")
 ... W ?59,$S($P(ACKSTR,U,3):$P(ACKSTR,U,3),1:"0")
 ...;
 ...;  Calculate Totals
 ... S @("ACKCSCT"_AS)=@("ACKCSCT"_AS)+$P(ACKSTR,U,1)
 ... S @("ACKCSTT"_AS)=@("ACKCSTT"_AS)+$P(ACKSTR,U,2)
 ... S @("ACKCSUT"_AS)=@("ACKCSUT"_AS)+$P(ACKSTR,U,3)
 ..;
 .. Q:$D(DIRUT)
 . Q:$D(DIRUT)
 . S $P(LN,"-",80)="" W !,LN
 . W !," "_XAS," Total: ",?32,@("ACKCSCT"_AS),?45,@("ACKCSTT"_AS)
 . W ?59,@("ACKCSUT"_AS),!
 ;
 Q:$D(DIRUT)
 ;  Calculate and Display Grand Total for CPT
 N ACKGT1,ACKGT2,ACKGT3
 S ACKGT1=$G(ACKCSCTS)+$G(ACKCSCTA)
 S ACKGT2=$G(ACKCSTTS)+$G(ACKCSTTA)
 S ACKGT3=$G(ACKCSUTS)+$G(ACKCSUTA)
 ;
 I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ICDCPTHD W !," "_XAS,":"
 W !," Grand Total",?32,ACKGT1,?45,ACKGT2,?59,ACKGT3,!
 D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 ;
 Q
 ;
SUMEC ;  Display summary of EC data
 Q:'$D(^TMP("ACKQDWLP",$J,"S",5))
 ;
 N ACKF,ACKCSCTA,ACKCSTTA,ACKCSUTA,ACKDD,ACKCC
 N ACKSTR,ACKCSCTS,ACKCSTTS,ACKCSUTS,ACKTYPE
 S (ACKCSCTA,ACKCSTTA,ACKCSUTA,ACKCSCTS,ACKCSTTS,ACKCSUTS)=0
 S ACKTYPE="EC"
 ;  Display main heading and sub heading
 D HEADER,ICDCPTHD
 S AS=""
 F  S AS=$O(^TMP("ACKQDWLP",$J,"S",5,AS)) Q:AS=""!($D(DIRUT))  D
 . I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ICDCPTHD
 . S XAS=$S(AS="A":"Audiology",1:"Speech Pathology")
 . W !," "_XAS,":"
 . S (ACKCC,ACKSTR)=""
 .;
 . F  S ACKCC=$O(^TMP("ACKQDWLP",$J,"S",5,AS,ACKCC)) Q:ACKCC=""!($D(DIRUT))  D
 .. I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ICDCPTHD W " "_XAS,":"
 .. S ACKF=1,ACKDD=""
 .. F  S ACKDD=$O(^TMP("ACKQDWLP",$J,"S",5,AS,ACKCC,ACKDD))  Q:ACKDD=""!($D(DIRUT))  D
 ... S ACKSTR=^TMP("ACKQDWLP",$J,"S",5,AS,ACKCC,ACKDD)
 ...;  Print EC data
 ... W !
 ... I ACKF W " "_$$GET1^DIQ(725,ACKCC_",",1,"I") S ACKF=0
 ... W ?9,$P(ACKDIV(ACKDD),U,3)
 ... W ?32,$S($P(ACKSTR,U,1):$P(ACKSTR,U,1),1:"0")
 ... W ?45,$S($P(ACKSTR,U,2):$P(ACKSTR,U,2),1:"0")
 ... W ?59,$S($P(ACKSTR,U,3):$P(ACKSTR,U,3),1:"0")
 ...;
 ...;  Calculate Totals
 ... S @("ACKCSCT"_AS)=@("ACKCSCT"_AS)+$P(ACKSTR,U,1)
 ... S @("ACKCSTT"_AS)=@("ACKCSTT"_AS)+$P(ACKSTR,U,2)
 ... S @("ACKCSUT"_AS)=@("ACKCSUT"_AS)+$P(ACKSTR,U,3)
 ..;
 .. Q:$D(DIRUT)
 . Q:$D(DIRUT)
 . S $P(LN,"-",80)="" W !,LN
 . W !," "_XAS," Total: ",?32,@("ACKCSCT"_AS),?45,@("ACKCSTT"_AS)
 . W ?59,@("ACKCSUT"_AS),!
 ;
 Q:$D(DIRUT)
 ;  Calculate and Display Grand Total for EC
 N ACKGT1,ACKGT2,ACKGT3
 S ACKGT1=$G(ACKCSCTS)+$G(ACKCSCTA)
 S ACKGT2=$G(ACKCSTTS)+$G(ACKCSTTA)
 S ACKGT3=$G(ACKCSUTS)+$G(ACKCSUTA)
 ;
 I $Y>(IOSL-5) D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)  D HEADER,ICDCPTHD W !," "_XAS,":"
 W !," Grand Total",?32,ACKGT1,?45,ACKGT2,?59,ACKGT3,!
 ;
 ; D:$E(IOST)="C" PAUSE^ACKQUTL Q:$D(DIRUT)
 Q
 ;
HEADER ;  Display heading of summary report section 
 N X
 S ACKPG=ACKPG+1 W @IOF,"Printed: ",ACKCDT,?(IOM-8),"Page: ",ACKPG
 F X="Audiology & Speech Pathology","Capitation Report Summary Report by "_ACKTYPE_" Code",$$XDAT^ACKQUTL(ACKM) W ! D CNTR^ACKQUTL(X)
 W !
 Q
 ;
ZIPHD ;  Display sub heading for ZIP code
 N X
 W !," "_ACKTYPE,?9,"DIVISION",?30,"CLINIC",?43,"TELEPHONE",?58,"UNIQUE"
 W !," EXAMS",?30,"VISITS",?44,"VISITS",?57,"PATIENTS",?71,"C&P"
 D LINE
 Q
 ;
ICDCPTHD ;  Display sub heading for ICD/CPT code
 N X
 W !," "_ACKTYPE,?9,"DIVISION",?30,"CLINIC",?43,"TELEPHONE",?58,"UNIQUE"
 W !," EXAMS",?30,"VISITS",?44,"VISITS",?57,"PATIENTS"
 D LINE
 Q
 ;
 ;
LINE ;  Write line if dashes
 S X="",$P(X,"-",IOM)="-" W !,X
 Q
 ;
