RORHL16 ;HOIFO/BH,SG - HL7 VITALS DATA: OBR,OBX ; 8/31/05 2:16pm
 ;;1.5;CLINICAL CASE REGISTRIES;;Feb 17, 2006
 ;
 ; This routine uses the following IAs:
 ;
 ; #1446         EN1^GMRVUT0 (controlled)
 ;
 Q
 ;
 ;***** SEARCHES FOR VITALS DATA
 ;
 ; RORDFN        IEN of the patient in the PATIENT file (#2)
 ;
 ; .DXDTS        Reference to a local variable where the
 ;               data extraction time frames are stored.
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
 ; The function uses ^UTILITY($J,"GMRVD") global node.
 ;
EN1(RORDFN,DXDTS) ;
 N DFN,GMRVSTR,IDX,PAT,RC,RORENDT,RORSTDT
 S (ERRCNT,RC)=0
 ;
 S IDX=0
 F  S IDX=$O(DXDTS(15,IDX))  Q:IDX'>0  D  Q:RC<0
 . S RORSTDT=$P(DXDTS(15,IDX),U),RORENDT=$P(DXDTS(15,IDX),U,2)
 . ;--- Check to see if the patient has any Vitals data
 . K ^UTILITY($J,"GMRVD")
 . S DFN=RORDFN,GMRVSTR="BP;T;R;P;HT;WT;PN"
 . S GMRVSTR(0)=RORSTDT_"^"_RORENDT_"^999999^0"
 . D EN1^GMRVUT0
 . Q:$D(^UTILITY($J,"GMRVD"))<10
 . ;--- Process the data
 . S TMP=$$OBR()
 . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 . S TMP=$$OBX()
 . I TMP  Q:TMP<0  S ERRCNT=ERRCNT+TMP
 ;
 K ^UTILITY($J,"GMRVD")
 Q $S(RC<0:RC,1:ERRCNT)
 ;
 ;***** VITALS OBR SEGMENT BUILDER
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBR() ;
 N CS,ERRCNT,RC,RORSEG
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 ;--- Initialize the segment
 S RORSEG(0)="OBR"
 ;
 ;--- OBR-4 - Vitals CPT Code
 S RORSEG(4)="94150"_CS_"VITAL CAPACITY TEST"_CS_"C4"
 ;
 ;--- OBR-24 - Diagnostic Service ID
 S RORSEG(24)="EC"
 ;
 ;--- OBR-44 - Division
 S RORSEG(44)=$$SITE^RORUTL03(CS)
 ;
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q ERRCNT
 ;
 ;***** VITALS OBX SEGMENT(S) BUILDER
 ;
 ; Return Values:
 ;       <0  Error code
 ;        0  Ok
 ;       >0  Non-fatal error(s)
 ;
OBX() ;
 N CS,ERRCNT,RC,OBID
 S (ERRCNT,RC)=0
 D ECH^RORHL7(.CS)
 ;
 F OBID="BP^Blood Pressue^VA080","T^Temperature^VA080","R^Respiration^VA080","P^Pulse^VA080","HT^Height^VA080","WT^Weight^VA080","PN^Pain^VA080"  D
 . D VITALTYP($TR(OBID,"^",CS),CS)
 ;
 Q ERRCNT
 ;
 ;***** LOOPS THROUGH THE UTILITY GLOBAL FOR VITAL TYPE
VITALTYP(OBID,CS) ;
 N BODYMASS,DATA,DTE,IEN,MEASDATE,OBX5,TYPE,UNITS
 S TYPE=$P(OBID,CS)
 Q:'$D(^UTILITY($J,"GMRVD",TYPE))
 ;---
 S DTE=""
 F  S DTE=$O(^UTILITY($J,"GMRVD",TYPE,DTE))  Q:'DTE  D
 . S IEN=""
 . F  S IEN=$O(^UTILITY($J,"GMRVD",TYPE,DTE,IEN))  Q:'IEN  D
 . . S DATA=^UTILITY($J,"GMRVD",TYPE,DTE,IEN)
 . . ;
 . . S MEASDATE=$P(DATA,U)  ;??? Temporary fix for Vitals API bug
 . . I $L(MEASDATE)=8  S:$E(MEASDATE,8)="0" MEASDATE=$E(MEASDATE,1,7)
 . . S MEASDATE=$$FM2HL^RORHL7(MEASDATE)
 . . S UNITS=$P(DATA,U,13)
 . . S BODYMASS=$S(TYPE="WT":$P(DATA,U,14),1:"")
 . . ;
 . . S OBX5=$P(DATA,U,8)_U_$P(DATA,U,11)_U_$P(DATA,U,17)
 . . D SETOBX(OBID,IEN,OBX5,UNITS,BODYMASS,MEASDATE)
 ;
 Q
 ;
 ;*** CREATES AND STORES THE OBX SEGMENT
SETOBX(OBX3,OBX4,OBX5,OBX6,OBX7,OBX14) ;
 N RORSEG
 ;--- Initialize the segment
 S RORSEG(0)="OBX"
 ;--- OBX-2
 S RORSEG(2)="FT"
 ;---
 S RORSEG(3)=OBX3
 S RORSEG(4)=OBX4
 S RORSEG(5)=$$ESCAPE^RORHL7(OBX5)
 S:$G(OBX6)'="" RORSEG(6)=OBX6
 S:$G(OBX7)'="" RORSEG(7)=OBX7
 S:$G(OBX14)'="" RORSEG(14)=OBX14
 ;--- OBX-11
 S RORSEG(11)="F"
 ;--- Store the segment
 D ADDSEG^RORHL7(.RORSEG)
 Q
