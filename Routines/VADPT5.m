VADPT5 ;ALB/MRL/MJK - PATIENT VARIABLES [REG]; 14 DEC 1988 ; 8/6/04 7:42am
 ;;5.3;Registration;**54,63,242,584,749**;Aug 13, 1993;Build 10
10 ;Registration/Disposition [REG]
 N VARPSV
 S VARPSV("C")=$S('$G(VARP("C")):999999999,1:+VARP("C"))
 S VARPSV("F")=9999999-$S($G(VARP("F"))?7N.E:VARP("F"),1:0)
 S VARPSV("T")=$S($G(VARP("T"))?7N.E:VARP("T"),1:7777777) I '$P(VARPSV("T"),".",2) S $P(VARPSV("T"),".",2)=999999
 S VARPSV("T")=9999999-VARPSV("T")
 S VAX=VARPSV("T"),VAX(1)=0
 I '$D(^DPT(DFN,"DIS")) Q
 F I=0:0 S VAX=$O(^DPT(DFN,"DIS",VAX)) Q:VAX=""!(VAX>VARPSV("F"))!(VAX(1)+1>VARPSV("C"))  S VAX(2)=$G(^DPT(DFN,"DIS",VAX,0)),VAX(1)=VAX(1)+1 D 101:+VAX(2)>0
 Q
101 S (VAX("I"),VAX("E"))="",VAX(3)=0 F I=1,2,3,4,5,6,7,9 S VAX(3)=VAX(3)+1,$P(VAX("I"),"^",VAX(3))=$P(VAX(2),"^",I) D 102
 S @VAV@(VAX(1),"I")=VAX("I"),@VAV@(VAX(1),"E")=VAX("E") Q
102 I "^1^6^"[("^"_VAX(3)_"^") S Y=$P(VAX("I"),"^",VAX(3)) I Y]"" X ^DD("DD") S $P(VAX("E"),"^",VAX(3))=Y Q
 S X(1)=$S($D(^DD(2.101,$S(I<9:(I-1),1:I),0)):$P(^(0),"^",3),1:"") I "^2^3^"[("^"_VAX(3)_"^"),$P(VAX("I"),"^",VAX(3))]"",X(1)]"" S $P(VAX("E"),"^",VAX(3))=$P($P(X(1),$P(VAX("I"),"^",VAX(3))_":",2),";",1) Q
 I "^4^5^7^8^"[("^"_VAX(3)_"^"),$P(VAX("I"),"^",VAX(3))]"",X(1)]"" S X(1)="^"_X(1)_$P(VAX("I"),"^",VAX(3))_",0)" I $D(@(X(1))) S $P(VAX("E"),"^",VAX(3))=$P(^(0),"^",1)
 Q
 ;
11 ;Clinic Enrollments [SDE]
 S (VAX,VAX(1))=0 F I=0:0 S VAX=$O(^DPT(DFN,"DE",VAX)) Q:VAX'>0  S VAZ=$S($D(^DPT(DFN,"DE",VAX,0)):^(0),1:"") I +VAZ,$P(VAZ,"^",2)'="I" S VAX(3)=0 D 111
 Q
111 S VAX(4)=0 F I1=0:0 S VAX(4)=$O(^DPT(DFN,"DE",VAX,1,VAX(4))) Q:VAX(4)'>0!(VAX(3))  S VAZ(1)=$S($D(^DPT(DFN,"DE",VAX,1,VAX(4),0)):^(0),1:"") I +VAZ(1),$P(VAZ(1),"^",3)']"" S VAX(3)=VAZ(1)
 Q:'VAX(3)  S (VAX("I"),VAX("E"))="",Y=+VAX(3),$P(VAX("I"),"^",2)=Y X ^DD("DD") S $P(VAX("E"),"^",2)=Y
 S $P(VAX("I"),"^",3)=$P(VAX(3),"^",2) I $P(VAX("I"),"^",3)]"" S $P(VAX("E"),"^",3)=$S($P(VAX("I"),"^",3)="O":"OPT",$P(VAX("I"),"^",3)="A":"AC",1:"")
 S $P(VAX("I"),"^",1)=+VAZ,$P(VAX("E"),"^",1)=$S($D(^SC(+VAZ,0)):$P(^(0),"^",1),1:""),VAX(1)=VAX(1)+1,@VAV@(VAX(1),"I")=VAX("I"),@VAV@(VAX(1),"E")=VAX("E") Q
 ;
12 ;Appointments [SDA]
 N VASDSV,SDCNT,SDARRAY,VANOW
 S VANOW=$$NOW^XLFDT
 S VASDSV("F")=$S($G(VASD("F"))?7N.E:VASD("F"),1:VANOW)
 S VASDSV("T")=$S(+$G(VASD("T")):+VASD("T"),1:9999999) I '$P(VASDSV("T"),".",2) S $P(VASDSV("T"),".",2)=999999
 S VASDSV("W")=$S('$G(VASD("W")):12,1:VASD("W"))
 S VAZ(2)=$S($D(VASD("N")):VASD("N"),1:9999)
 ;Set STATUS Codes (VistA;RSA)
 S VAZ=";R^I;I^N;NS^NA;NSR^C;CC^CA;CCR^PC;CP^PCA;CPR^NT;NT^",VAZ(1)=""
 ;Extract User Required STATUS Codes in RSA format
 F I=1:1 S I1=+$E(VASDSV("W"),I) Q:'I1  D
 .S VAZ(1)=VAZ(1)_$P($P(VAZ,"^",I1),";",2)_";"
 ;Create parameter list for the extrinsic call to the Appointment API
 ;Note: Appointment API can only accept a maximum of 3 fields 
 ;               to filter on.
 ; 1 : "FROM;TO" Appointment Date Range to Search
 ; 2 : Clinic IEN or Array of Clinic IENs if defined (Pass the Root)
 ; 3 : Requested STATUS Codes (Passed if VASD("C") is not defined.)
 ; 4 : Patient IEN
 S SDARRAY="",SDARRAY(1)=VASDSV("F")_";"_VASDSV("T")
 I $O(VASD("C",0))>0 S SDARRAY(2)="VASD(""C"","
 E  S SDARRAY(3)=VAZ(1)
 S SDARRAY(4)=DFN
 ;Set Fields for API to Return
 ;  1 : Appointment Date/Time
 ;  2 : Clinic
 ;  3 : Appointment Status
 ; 10 : Appointment Type
 S SDARRAY("FLDS")="1;2;3;10"
 ;Remove Clinic IEN from Global Reference
 S SDARRAY("SORT")="P"
 ;Call Appointment API (Pass Array by reference)
 S SDCNT=$$SDAPI^SDAMA301(.SDARRAY)
 S VAX="",VAX(1)=0
 ;If error returned, determine error and set VAERR appropriately
 ; 1 : For any error other than 101
 ; 2 : If error is 101 : Database is unavailable  
 I SDCNT<0 S VAX=$O(^TMP($J,"SDAMA301",VAX)) S VAERR=$S(VAX=101:2,1:1) K ^TMP($J,"SDAMA301") Q
 D 122:SDCNT>0
 Q
121 S VAX(5)=1 I VASDSV("W")'[1,$P(VAZ,"^",2)']"" S VAX(5)=0 Q
 I VASDSV("C"),'$D(VASD("C",+VAZ)) S VAX(5)=0 Q
 S (VAX("I"),VAX("E"))="",VAX(2)=1,$P(VAX("I"),"^",1)=+VAX F I1=1,2,16 S VAX(2)=VAX(2)+1,$P(VAX("I"),"^",VAX(2))=$P(VAZ,"^",I1)
 Q
122 ;Build Internal/External Output Globals
 ;
 N SDCIEN,SDDTM,SDNODE
 S (SDCIEN,SDDTM)=""
 ;Redefine VAZ (STATUS Codes(RSA;VistA))
 S VAZ="R;^I;I^NS;N^NSR;NA^CC;C^CCR;CA^CP;PC^CPR;PCA^NT;NT^"
 S SDDTM=""
 ;Loop through appointments and convert for output
 F  S SDDTM=$O(^TMP($J,"SDAMA301",DFN,SDDTM)) Q:'SDDTM  D 
 .;Get Appointment Information and clear VAX("I") & VAX("E")
 .S SDNODE=^(SDDTM),(VAX("I"),VAX("E"))=""
 .;If Clinics were passed to appointment API,
 .;     Filter on Appointment Status Codes
 .I $O(VASD("C",0))>0,(VAZ(1)'[($P($P(SDNODE,"^",3),";")_";")) Q
 .;Extract and format Appointment Date/Time
 .S Y=$P(SDNODE,"^",1)
 .S $P(VAX("I"),"^",1)=Y
 .X ^DD("DD") S $P(VAX("E"),"^",1)=Y
 .;Extract and format Clinic Information
 .S $P(VAX("I"),"^",2)=$P($P(SDNODE,"^",2),";",1)
 .S $P(VAX("E"),"^",2)=$P($P(SDNODE,"^",2),";",2)
 .;Extract and format Appointment Type
 .S $P(VAX("I"),"^",4)=$P($P(SDNODE,"^",10),";",1)
 .S $P(VAX("E"),"^",4)=$P($P(SDNODE,"^",10),";",2)
 .;Extract and format Appointment Status
 .S Y=$P($P(VAZ,$P($P(SDNODE,"^",3),";")_";",2),"^"),$P(VAX("I"),"^",3)=Y
 .I Y]"" S X=$S($D(^DD(2.98,3,0)):$P(^(0),"^",3),1:""),$P(VAX("E"),"^",3)=$P($P(X,Y_":",2),";",1)
 .S VAX(1)=VAX(1)+1
 .;Store information in global
 .S @VAV@(VAX(1),"I")=VAX("I"),@VAV@(VAX(1),"E")=VAX("E")
 K ^TMP($J,"SDAMA301")
 Q
