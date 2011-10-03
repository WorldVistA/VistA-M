VAQPST51 ;ALB/JRP - CREATE DATA SEGMENT FROM H.S. COMPONENT;28-APR-94
 ;;1.5;PATIENT DATA EXCHANGE;**4**;NOV 17, 1993
PATCH4 ;ENTRY POINT FOR PATCH NUMBER 4
 ;  REFER TO VAQ*1.5*4 IN NATIONAL PATCH MODULE FOR FURTHER DETAILS
 ;
 ;DECLARE VARIABLES
 N ERR,POINT,COMP,DASHES,DOTS,PDXCOMP
 S DASHES=$TR($J(" ",79)," ","-")
 W !!,"This entry point will create PDX Data Segments for the following"
 W !,"Health Summary Components: "
 W !,?3,"(1) Discharge Summary"
 W !,?3,"(2) Brief Discharge Summary"
 W !
 W !,"Further details may be obtained from the National Patch Module"
 W !,"under the entry VAQ*1.5*4 (patch # 4 for version 1.5 of PDX)."
 W !,DASHES,!
 S DOTS=$TR(DASHES,"-",".")
 ;ADD DISCHARGE SUMMARY & DISCHARGE SUMMARY BRIEF TO DATA SEGMENT FILE
 F COMP="DISCHARGE SUMMARY","DISCHARGE SUMMARY BRIEF" D
 .;CONVERT TO PDX SEGMENT NAME
 .S PDXCOMP=$$FIRSTUP^VAQPST50(COMP)
 .;GET POINTER TO COMPONENT
 .S POINT=+$O(^GMT(142.1,"B",COMP,0))
 .I ('POINT) D  Q
 ..W !!,$C(7),"** ",COMP," not found in HEALTH SUMMARY COMPONENT file **"
 ..W !,"** ",PDXCOMP," not added to VAQ - DATA SEGMENT file **",$C(7)
 .;CREATE DATA SEGMENT USING DEFAULT TIME & OCCURRENCE LIMITS
 .W !,"Adding ",PDXCOMP," to VAQ - DATA SEGMENT file (#394.71)"
 .S ERR=$$ADDSEG^VAQPST50(POINT)
 .I (ERR<0) D  Q
 ..W !,?2,$C(7),"** ERROR **"
 ..W !,?2,"** ",$P(ERR,"^",2)," **",$C(7)
 .W " ",$E(DOTS,1,(74-$X))," Done"
 ;DONE
 W !
 Q
