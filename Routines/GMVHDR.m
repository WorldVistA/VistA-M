GMVHDR ;HIOFO/FT-HEALTH DATA REPOSITORY API ;10/21/04  13:03
 ;;5.0;GEN. MED. REC. - VITALS;**2,17**;Oct 31, 2002
 ;11/30/2005 KAM/BAY Remedy Call 121661 changes for HL7 message
 ;
 ; This routine uses the following IAs:
 ; <None>
 ;
 ; This routine supports the following IAs:
 ; EN - #4583           (Private)
 ;
EN(GMVIEN) ; This function returns a string containing the values
 ; for the record number provided.
 ;
 ;  Input: GMVIEN - FILE 120.5 Internal Entry Number (IEN)
 ; Output: A string of data where:
 ;         piece 1 = (#.01) DATE/TIME VITALS TAKEN (internal)
 ;         piece 2 = (#.02) PATIENT (internal)
 ;         piece 3 = (#.03) VITAL TYPE (external)
 ;         piece 4 = (#.04) DATE/TIME VITALS ENTERED (internal)
 ;         piece 5 = (#.05) HOSPITAL LOCATION (internal)
 ;         piece 6 = (#.06) ENTERED BY (internal)
 ;         piece 7 = (#.03) VITAL TYPE (internal)
 ;         piece 8 = (#1.2) RATE
 ;         piece 9 = UNITS (value is computed by this routine)
 ;         piece 10 = (#1.4) SUPPLEMENTAL O2 (internal)
 ;         piece 11 = (#2) ENTERED IN ERROR (internal)
 ;         piece 12 = (#3) ERROR ENTERED BY (internal)
 ;         piece 13 = (#4) REASON ENTERED IN ERROR (multiple) (external)
 ;                    Values are separated by a tilde (~).
 ;         piece 14 = (#5) QUALIFIER (multiple) (external)
 ;                    Values are separated by a tilde (~).
 ;
 ; Returns a null value if the entry does not exist.
 ;
 I '$G(GMVIEN) Q ""
 N GMVA,GMVLIST,GMVLOOP,GMVNODE,GMVNODE2,GMVQUALE,GMVQUALI,GMVUNIT,GMVVTE,GMVVTI,GMVX
 S GMVNODE=$G(^GMR(120.5,+GMVIEN,0)) ; zero node of patient record
 ; check if record is complete
 F GMVLOOP=1,2,3,4,5,6,8 I $P(GMVNODE,U,GMVLOOP)="" D
 .H 1
 .S GMVNODE=$G(^GMR(120.5,+GMVIEN,0)) ;get zero node again
 .Q
 I GMVNODE="" Q ""
 I $P(GMVNODE,U,1)'>0 Q ""  ;date/time vitals taken
 I $P(GMVNODE,U,2)'>0 Q ""  ;dfn
 S GMVVTI=+$P(GMVNODE,U,3) ;vital type ien
 S GMVVTE=$P($G(^GMRD(120.51,GMVVTI,0)),U,1) ;vital type name
 I GMVVTE="" Q ""
 I $$ACTIVE^GMVUID(120.51,"",GMVVTI_",","") Q ""  ; not active vuid
 S GMVA=$P($G(^GMRD(120.51,GMVVTI,0)),U,2) ;vital abbreviation
 S $P(GMVNODE,U,3)=GMVVTE,$P(GMVNODE,U,7)=GMVVTI
 S GMVUNIT=$S(GMVA="BP":"mmHg",GMVA="T":"F",GMVA="R":"/min",GMVA="P":"/min",GMVA="HT":"in",GMVA="WT":"lb",GMVA="CVP":"cmH2O",GMVA="CG":"in",GMVA="PO2":"%SpO2",1:"")
 S $P(GMVNODE,U,9)=GMVUNIT
 S:+$P(GMVNODE,U,5)'>0 $P(GMVNODE,U,5)="" ;hospital location
 S:+$P(GMVNODE,U,6)'>0 $P(GMVNODE,U,6)="" ;entered by
 S GMVNODE2=$G(^GMR(120.5,GMVIEN,2))
 S $P(GMVNODE,U,11)=$S($P(GMVNODE2,U,1)=1:"YES",1:"")
 S $P(GMVNODE,U,12)=$S($P(GMVNODE2,U,2)>0:$P(GMVNODE2,U,2),1:"")
 ; reason (multiple)
 S GMVLOOP=0,GMVLIST=""
 F  S GMVLOOP=$O(^GMR(120.5,GMVIEN,2.1,GMVLOOP)) Q:'GMVLOOP  D
 .S GMVX=$P($G(^GMR(120.5,GMVIEN,2.1,GMVLOOP,0)),U,1)
 .Q:GMVX=""
 .S GMVX=GMVX_"-"_$S(GMVX=1:"INCORRECT DATE/TIME",GMVX=2:"INCORRECT READING",GMVX=3:"INCORRECT PATIENT",GMVX=4:"INVALID RECORD",1:"")
 .S GMVLIST=GMVLIST_GMVX_"~"
 .Q
 I $E(GMVLIST,$L(GMVLIST))="~" S GMVLIST=$E(GMVLIST,1,($L(GMVLIST)-1))
 S $P(GMVNODE,U,13)=GMVLIST
 ;qualifiers (multiple)
 S GMVLOOP=0,GMVLIST=""
 F  S GMVLOOP=$O(^GMR(120.5,GMVIEN,5,GMVLOOP)) Q:'GMVLOOP  D
 .S GMVQUALI=$P($G(^GMR(120.5,GMVIEN,5,GMVLOOP,0)),U,1)
 .S GMVQUALE=$P($G(^GMRD(120.52,+GMVQUALI,0)),U,1)
 .Q:GMVQUALE=""
 .S GMVLIST=GMVLIST_GMVQUALE_"~"
 .Q
 I $E(GMVLIST,$L(GMVLIST))="~" S GMVLIST=$E(GMVLIST,1,($L(GMVLIST)-1))
 S $P(GMVNODE,U,14)=GMVLIST
 Q GMVNODE
 ;
