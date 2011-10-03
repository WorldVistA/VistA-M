EEOIPCON ;HISC/JWR - POST INIT FIELD 14 FILE 785 CONVERSION ;02/08/93 11:15
 ;;2.0;EEO Complaint Tracking;;Apr 27, 1995
EN ;
 K EEO S DA=0 F  S DA=$O(^EEO(785,DA)) Q:DA'>0  I $P($G(^(DA,1)),U)'="" S COUN=$P($G(^(1)),U) D
 .Q:$D(^VA(200,COUN))
 .S EEO(COUN,DA)=COUN
 S N1=0 F  S N1=$O(EEO(N1)) Q:N1=""  S N2=0 F  S N2=$O(EEO(N1,N2)) Q:N2=""  D NAME Q:LNAME=""  D
 .K CEE,DEE S CEE(LNAME)=$O(^VA(200,"B",LNAME)),DEE(LNAME)=$O(^VA(200,"B",LNAME))
 .K AEE,BEE F X=$L(FNAME):-1:0 D
 ..I $D(^VA(200,"B",LNAME_","_FNAME)) S NUM=$O(^(LNAME_","_FNAME,"")) D SET Q
 ..S AEE(X)=$O(^VA(200,"B",LNAME_","_$E(FNAME,X))),BEE(X)=$O(^VA(200,"B",AEE(X))) D:$P(CEE(LNAME),",")[$P(AEE(X),",")
 ...I BEE(X)'[AEE(X)&(AEE(X)[LNAME_","_$E(FNAME,X)) S NUM=$O(^VA(200,"B",AEE(X),"")) D SET Q
 ..Q
 Q:'$D(EEO)
REPORT W !!,"The Counselor's Name Field (#14, File 785) has been changed from free text",!,"to a pointer to File 200, enter a device to print the names of counselor's",!,"who could not be converted.",!!
 S %ZIS="Q" K IOP,ZTIO,ZTSAVE D ^%ZIS G:POP=1 EXIT
 I $D(IO("Q")) S EEOQ=1,ZTRTN="START^EEOIPCON",ZTSAVE("EEO*")="",ZTDESC=" " D ^%ZTLOAD G EXIT
 D START G EXIT
START U IO
 W !,"                   EEO COUNSELOR'S NAMES CONVERSION:"
 W !!,"Cases with counselors that are yet to be converted to point to New Person file",!,"                COUNSELOR'S NAME  (FLD #14 FILE #785)",!!
 D HEAD S N1="" F  S N1=$O(EEO(N1)) Q:N1=""  S N2=0 F  S N2=$O(EEO(N1,N2)) Q:N2=""  D LINE
 W !!,"This list contains the names of counselors who must be converted manually to",!,"reflect their New Person file entry.  The IRM may do this by editing",!,"field # 14 (Counselor's Name) of file 785 (EEO Complaints) through VA File",!
 W "Man and changing the above listed name to the correct New Person name (in File ",!,"200), or the EEO Specialist may edit this through the Enter/Edit Formal",!,"Complaint Info option."
 D EXIT Q
SET S N3=0 F  S N3=$O(EEO(N1,N3)) Q:N3=""  S $P(^EEO(785,N3,1),U)=NUM K EEO(N1,N3)
 K NUM Q
NAME I N1["," S LNAME=$P(N1,","),FNAME=$P(N1,",",2)
 E  S LNAME=$P(N1," ",2),FNAME=$P(N1," ") S:LNAME[" " LNAME=$P(LNAME," ",2)
 Q
HEAD S EZE=0 W !!,"      CASE NUMBER                 COUNSELOR'S NAME",! S $P(EO,"_",63)="" W EO Q
LINE S CASE=$P($G(^EEO(785,N2,5)),U,6),EZE=EZE+1
 W !,EZE_"."_$J("   ",5-$L(EZE)),CASE,$J("   ",28-$L(CASE)),N1,$J(" ",35-$L(N1))
 Q
EXIT D ^%ZISC K CASE,COUN,DA,EO,LNAME,FNAME,N1,N2,N3,EZE,EEO Q
 Q
CLNODE ;Finishes cleaning data from fields that are to be deleted for V. 2.0.
 S $P(^EEO(785,DA,0),U,6)=""
 S:$P($G(^EEO(785,DA,5)),U,2)'="" $P(^(5),U,2)=""
 S EEONO3=$G(^EEO(785,DA,3)) I EEONO3'="" S ^(3)="^^"_$P(EEONO3,U,3)_"^^^"_$P(EEONO3,U,6)
 S EEONO3=$G(^EEO(785,DA,1)) I EEONO3'="" F NOT=4,5,7,8,9,10 D
 .S $P(EEONO3,U,NOT)=""
 S:EEONO3'="" ^EEO(785,DA,1)=EEONO3
 K EEONO3,NOT Q 
