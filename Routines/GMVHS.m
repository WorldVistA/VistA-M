GMVHS ;HIOFO/FT-RETURN PATIENT DATA UTILITY ;10/3/07
 ;;5.0;GEN. MED. REC. - VITALS;**3,23**;Oct 31, 2002;Build 25
 ;
 ; This routine uses the following IAs:
 ;  #4290 - ^PXRMINDX global       (controlled)
 ; #10040 - FILE 44 references     (supported)
 ; #10103 - ^XLFDT calls           (supported)
 ; #10104 - ^XLFSTR calls          (supported)
 ;
 ; This routine supports the following IAs:
 ; EN1 - 4791                       (private)
 ;
EN1 ; Entry to gather patient's vital/measurement data
 ; Input variables
 ;
 ;     DFN = Entry number of patient in Patient file. (Required)
 ; GMRVSTR = types of vital/measurements desired.  Use the abbreviations
 ;           found in the Vital Type (120.51) file.  For multiple
 ;           vitals, use the ; as a delimiter. (Required)
 ; GMRVSTR(0) = GMRVSTDT^GMRVENDT^GMRVOCC^GMRVSORD
 ;         where GMRVSTDT = The start date/time that the utility will
 ;                          use in obtaining patient data.  (Required)
 ;               GMRVENDT = The end date/time that the utility will use
 ;                          to stop the search.  (Required)
 ;               GMRVOCC  = The number of occurrences of the data that
 ;                          is desired by the search.  (Required)
 ;               GMRVSORD = The sort order desired in output. 0 will sort 
 ;                          the data by vital type, then by date/time entered.
 ;                          1 will sort the data by date/time entered, then by 
 ;                          vital type. (REQUIRED)
 ; GMRVSTR("LT") = ^TYP1^[TYP2^...]  (OPTIONAL)
 ;         THIS VARIABLE IS AN ^ DELIMITED LIST OF HOSPITAL LOCATION
 ;         TYPES TO EXTRACT MEASUREMENT DATA FOR.  E.G., ^C^M^, WILL
 ;         EXTRACT DATA FOR ONLY THOSE MEASUREMENTS TAKEN ON CLINICS
 ;         OR MODULES.
 ;
 ; Output variables:
 ;
 ; The utility will create an array with the desired information.  The
 ; array structure will be as follows if '$P(GMRVSTR(0),U,4):
 ;      ^UTILITY($J,"GMRVD",GMRVTYP,GMRVRDT,GMRVIEN)=GMRVDATA
 ; or if $P(GMRVSTR(0),U,4) then the following will be returned:
 ;      ^UTILITY($J,"GMRVD",GMRVRDT,GMRVTYP,GMRVIEN)=GMRVDATA
 ; where GMRVRDT  = Reverse FileMan date/time.
 ;                  9999999-Date/time vital/measurement was taken.
 ;       GMRVTYP  = The abbreviation used in the GMRVSTR string for the
 ;                  type of vital/measurement taken.
 ;       GMRVIEN  = Entry number in FILE 120.5 or
 ;                  pseudo entry number for File 704.117
 ;       
 ;       $P(GMRVDATA,"^",1) = date/time of the reading (FileMan internal) 
 ;       $P(GMRVDATA,"^",2) = Patient (#2) number (i.e., DFN) 
 ;       $P(GMRVDATA,"^",3) = vital type ien (File 120.51) 
 ;       $P(GMRVDATA,"^",4) = date/time of data entry (FileMan internal) 
 ;       $P(GMRVDATA,"^",5) = hospital location ien (File 44) 
 ;       $P(GMRVDATA,"^",6) = user ien (File 200) 
 ;       $P(GMRVDATA,"^",7) = always null 
 ;       $P(GMRVDATA,"^",8) = reading (e.g., 98.6, Unavailable) 
 ;       $P(GMRVDATA,"^",9) = always null
 ;       $P(GMRVDATA,"^",10) = the first qualifier
 ;       $P(GMRVDATA,"^",11) = the second qualifier
 ;       $P(GMRVDATA,"^",12)= "*" for abnormal measurement, otherwise = ""
 ;       $P(GMRVDATA,"^",13)= values in centigrade for T; kilos for WT; 
 ;                            centimeters for HT and Circumference/Girth;
 ;                            and mmHg for CVP
 ;       $P(GMRVDATA,"^",14)= Body Mass Index
 ;       $P(GMRVDATA,"^",15)= L/Min of supplemental O2
 ;       $P(GMRVDATA,"^",16)= % of supplemental O2
 ;       $P(GMRVDATA,"^",17)= all qualifiers delimited by semi-colons
 ; The variable GMRVSTR will be killed upon exit.
 ;
 Q:'$D(GMRVSTR(0))!'($D(GMRVSTR)#2)!'($D(DFN)#2)
 Q:DFN'>0
 I $G(GMRVSTR("LT"))="" S GMRVSTR("LT")="" ;hospital location list
HSKPING ; Housekeeping
 K ^UTILITY($J,"GMRVD")
 N GMVABNML,GMVDATA,GMVEND,GMVHTIEN,GMVID,GMVIEN,GMVLOOP,GMVMAX,GMVOCC,GMVRATE,GMVSORD,GMVSTART,GMVTIEN,GMVTYPE,GMVWTIEN
 D RANGE^GMVHS1
 F GMVLOOP=1:1:$L(GMRVSTR,";") D
 .S GMVTYPE=$P(GMRVSTR,";",GMVLOOP)
 .Q:GMVTYPE=""
 .S GMVMAX(GMVTYPE)=0
 .Q
 S GMVOCC=$P(GMRVSTR(0),U,3) ;max # of occurrences
 S GMVSORD=$P(GMRVSTR(0),U,4) ;sort order
 S GMVID=0 ;substitute IEN for GUID
 S GMVWTIEN=$$GETTYPEI("WT"),GMVHTIEN=$$GETTYPEI("HT")
 F GMRVSTR(1)=1:1:$L(GMRVSTR,";") S GMVTYPE=$P(GMRVSTR,";",GMRVSTR(1)) I $L(GMVTYPE) S GMVSTART=$S($P(GMRVSTR(0),U,1)>0:$P(GMRVSTR(0),U,1),1:0),GMVEND=$S($P(GMRVSTR(0),U,2):$P(GMRVSTR(0),U,2)+.000001,1:$$NOW^XLFDT()) D GETDATE
 K GMRVSTR
 Q
GETDATE ; Loop thru PXRMINDX xref
 S GMVTIEN=$O(^GMRD(120.51,"C",GMVTYPE,0)) ;vital type ien
 Q:'GMVTIEN
 S GMVLOOP=GMVEND
 F  S GMVLOOP=$O(^PXRMINDX(120.5,"PI",DFN,GMVTIEN,GMVLOOP),-1) Q:GMVLOOP<GMVSTART!(GMVLOOP'>0)!(GMVMAX(GMVTYPE)'<GMVOCC)  D GETNODE
 Q
GETNODE ; Get patient record
 N GMVCLIO,GMVQLIST,GMVQLOOP,GMVQNAME
 S GMVIEN=0
 F  S GMVIEN=$O(^PXRMINDX(120.5,"PI",DFN,GMVTIEN,GMVLOOP,GMVIEN)) Q:$L(GMVIEN)'>0!(GMVMAX(GMVTYPE)'<GMVOCC)  D
 .I GMVIEN=+GMVIEN D
 ..D F1205^GMVUTL(.GMVCLIO,GMVIEN)
 .I GMVIEN'=+GMVIEN D
 ..D CLIO^GMVUTL(.GMVCLIO,GMVIEN)
 .S GMVCLIO(0)=$G(GMVCLIO(0)),GMVCLIO(5)=$G(GMVCLIO(5))
 .I GMVCLIO(0)=""!($P(GMVCLIO(0),U,8)="") Q
 .I $L(GMRVSTR("LT")) Q:$P(GMVCLIO(0),U,5)'>0  Q:GMRVSTR("LT")'[("^"_$$GET1^DIQ(44,$P(GMVCLIO(0),U,5)_",",2,"I")_"^")  ;hospital location check
 .S GMVMAX(GMVTYPE)=GMVMAX(GMVTYPE)+1
 .S GMVRATE=$P(GMVCLIO(0),U,8)
 .D ZERONODE
 .S GMVQLIST=""
 .F GMVQLOOP=1:1 Q:$P($G(GMVCLIO(5)),U,GMVQLOOP)=""  D
 ..S GMVQNAME=$$FIELD^GMVGETQL($P(GMVCLIO(5),U,GMVQLOOP),1,"E")
 ..I GMVQNAME=""!(GMVQNAME=-1) Q
 ..S GMVQLIST=GMVQLIST_$S(GMVQLIST'="":";",1:"")_GMVQNAME
 .S $P(GMVDATA,U,17)=GMVQLIST
 .S $P(GMVDATA,U,10)=$P(GMVQLIST,";",1)
 .S $P(GMVDATA,U,11)=$P(GMVQLIST,";",2)
 .I GMVTYPE="PO2" D PO2($P(GMVCLIO(0),U,10))
 .D METRIC
 .D:$P(GMVCLIO(0),U,3)=GMVWTIEN BMI ;calculate BMI for weight
 .D:$$TEXT^GMVHS1(GMVRATE) ABNORMAL^GMVHS1
 .I GMVIEN=+GMVIEN S GMVID=GMVIEN
 .I GMVIEN'=+GMVIEN S GMVID=GMVID+1
 .D SET
 .Q
 Q
GETTYPEI(GMVTIEN) ; Return vital type (120.51) ien
 ; GMVTIEN = vital type abbreviation
 S GMVTIEN=$G(GMVTIEN)
 I GMVTIEN="" Q 0
 Q $O(^GMRD(120.51,"C",GMVTIEN,0))
 ;
ZERONODE ; Get zero node data
 S GMVDATA=$P($G(GMVCLIO(0)),U,1,8)_"^^^^^^^^^"
 Q
PO2(X) ; Get flow rate and liters/minute for Pulse Oximetry reading
 N GMVCONC,GMVFLOW
 S (GMVFLOW,GMVCONC)=""
 I X["%" D
 .S GMVCONC=$P(X,"%")
 .I GMVCONC["l/min" S GMVCONC=$P(GMVCONC,"l/min",2)
 I X["l/min" D
 .S GMVFLOW=$P(X,"l/min")
 .I GMVFLOW["%" S GMVFLOW=$P(GMVFLOW,"%",2)
 S GMVFLOW=$$STRIP^XLFSTR(GMVFLOW," ")
 S GMVCONC=$$STRIP^XLFSTR(GMVCONC," ")
 S $P(GMVDATA,U,15)=GMVFLOW
 S $P(GMVDATA,U,16)=GMVCONC
 Q
METRIC ; Calculate metric value for temperature, height, weight and
 ; circumference/girth
 N GMVMETRC
 S GMVMETRC=""
 Q:'$$TEXT^GMVHS1(GMVRATE)  ;quit if not a numeric reading
 I GMVTYPE="T" D
 .S GMVMETRC=$J(GMVRATE-32*5/9,0,1)
 .Q
 I GMVTYPE="HT" D
 .S GMVMETRC=$J(2.54*GMVRATE,0,2)
 .Q
 I GMVTYPE="WT" D
 .S GMVMETRC=$J(GMVRATE*.45359237,0,2)
 .Q
 I GMVTYPE="CG" D
 .S GMVMETRC=$J(2.54*GMVRATE,0,2)
 .Q
 I GMVTYPE="CVP" D
 .S GMVMETRC=$J(GMVRATE/1.36,0,2)
 .Q
 I GMVMETRC]"" S $P(GMVDATA,U,13)=GMVMETRC
 Q
BMI ; Calculate Body Mass Index
 N GMVBMI
 S GMVBMI=""
 S GMVBMI=$$CALCBMI^GMVHS1(GMVCLIO(0))
 S $P(GMVDATA,U,14)=GMVBMI
 Q
SET ; Set UTILITY($J,"GMRVD") node
 S:'GMVSORD ^UTILITY($J,"GMRVD",GMVTYPE,9999999-GMVLOOP,GMVID)=GMVDATA
 S:GMVSORD ^UTILITY($J,"GMRVD",9999999-GMVLOOP,GMVTYPE,GMVID)=GMVDATA
 Q
