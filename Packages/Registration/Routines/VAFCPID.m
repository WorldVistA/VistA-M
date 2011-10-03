VAFCPID ;ALB/MLI,PKE-Create generic PID segment ; 21 Nov 2002  3:13 PM
 ;;5.3;Registration;**91,149,190,415,508,749**;Aug 13, 1993;Build 10
 ;
 ; This routine returns the HL7 defined PID segment with its
 ; mappings to DHCP PATIENT file fields.
 ;
EN(DFN,VAFSTR,VAFNUM) ; returns PID segment
 ;  Input - DFN as internal entry number of the PATIENT file
 ;          VAFSTR as string of fields requested separated by commas
 ;          VAFNUM as sequential number for SET ID (default=1)
 ;
 ;      ****Also assumes all HL7 variables returned from****
 ;          INIT^HLTRANS are defined
 ;
 ; Output - String containing the desired components of the PID segment
 ;          VAFPID(n) - if the string is longer than 245, the remaining
 ;                      characters will be returned in VAFPID(n) where
 ;                      n is a sequential number beginning with 1
 ;
 ; WARNING: This routine makes external calls to VADPT.  Non-namespaced
 ;          variables may be altered.
 ;
 N I,VAFY,VA,VADM,X,X1,Y,OUTPUT,DGNAME,DGMMN,VAPA ; calls VADPT...have to NEW
 S VAFSTR=$G(VAFSTR) ; if not defined, just return required fields
 S DFN=$G(DFN)
 I DFN']"" G QUIT
 ;Get demographics and permanent address
 S VAPA("P")="" D 4^VADPT
 S VAFSTR=","_VAFSTR_","
 K VAFY
 ;Set ID (#1)
 I VAFSTR[",1," S VAFY(1)=$S($G(VAFNUM):VAFNUM,1:1)
 ;External ID (#2 - always included)
 S X=$$GETICN^MPIF001(DFN) S:(+X=-1) X="" S VAFY(2)=$S(X]"":X,1:HLQ)
 ;Patient ID (#3 - req)
 S VAFY(3)=$$M10^HLFNC(DFN)
 ;Alternate ID (#4)
 I VAFSTR[",4," S X=$G(VA("BID")),VAFY(4)=$S(X]"":X,1:HLQ)
 ;Name (#5 - req)
 S DGNAME("FILE")=2,DGNAME("IENS")=DFN,DGNAME("FIELD")=.01
 S X=$$HLNAME^XLFNAME(.DGNAME,"",$E(HLECH)),VAFY(5)=$S(X]"":X,1:HLQ)
 ;Mother's maiden name (#6)
 I VAFSTR[",6," D
 .S DGMMN("FILE")=2,DGMMN("IENS")=DFN,DGMMN("FIELD")=.2403
 .S X=$$HLNAME^XLFNAME(.DGMMN,"",$E(HLECH)),VAFY(6)=$S(X]"":X,1:HLQ)
 ;Date of birth (#7)
 I VAFSTR[",7," S VAFY(7)=$$HLDATE^HLFNC(+VADM(3))
 ;Sex (#8)
 I VAFSTR[",8," S X=$P(VADM(5),"^",1),VAFY(8)=$S("^M^F^"[("^"_X_"^"):X,1:"U")
 ;Race (#10)
 I VAFSTR[10 D
 .N HOW
 .S Y=$F(VAFSTR,"10")
 .S HOW=$P($E(VAFSTR,Y,$F(VAFSTR,",",Y)),",",1)
 .D SEQ10^VAFHLPI1(HOW,HLQ)
 ;Address (#11)
 I VAFSTR[11 D
 .N HOW
 .S Y=$F(VAFSTR,"11")
 .S HOW=$P($E(VAFSTR,Y,$F(VAFSTR,",",Y)),",",1)
 .D SEQ11^VAFHLPI2(HOW,HLQ)
 ;County (#12)
 I VAFSTR[12 S X1=$P($G(^DIC(5,+$G(VAPA(5)),1,+$G(VAPA(7)),0)),"^",3),VAFY(12)=$S(X1]"":X1,1:HLQ)
 S X=$G(^DPT(DFN,.13))
 ;Home phone (#13)
 I VAFSTR[13 S X1=$$HLPHONE^HLFNC($P(X,"^",1)),VAFY(13)=$S(X1]"":X1,1:HLQ)
 ;Business phone (#14)
 I VAFSTR[14 S X1=$$HLPHONE^HLFNC($P(X,"^",2)),VAFY(14)=$S(X1]"":X1,1:HLQ)
 ;Marital status (#16)
 I VAFSTR[16 S X=$P($G(^DIC(11,+VADM(10),0)),"^",3),VAFY(16)=$S(X="M":"M",X="N":"S",X="S":"A",X]"":X,1:HLQ)
 ;Religious preference (#17) (if blank send 29 (UNKNOWN))
 I VAFSTR[17 S X=$P($G(^DIC(13,+VADM(9),0)),"^",4),VAFY(17)=$S(X]"":X,1:29)
 ;SSN (#19)
 I VAFSTR[19 S X=$P(VADM(2),"^",1),VAFY(19)=$S(X]"":X,1:HLQ)
 ;Ethnicity (#22)
 I VAFSTR[22 D
 .N HOW
 .S Y=$F(VAFSTR,"22")
 .S HOW=$P($E(VAFSTR,Y,$F(VAFSTR,",",Y)),",",1)
 .D SEQ22^VAFHLPI1(HOW,HLQ)
 ;Birth place (#23)
 I VAFSTR[23 D
 .N DGBC,DGBS
 .S DGBC=$$GET1^DIQ(2,DFN,.092,"I")
 .S DGBS=$$GET1^DIQ(2,DFN,.093,"E")
 .S VAFY(23)=DGBC_" "_DGBS
 ;Date of death (#29) & Death indicator (#30) (always included if dead)
 S X=+VADM(6) I X D
 .S VAFY(29)=$$HLDATE^HLFNC(X)
 .S VAFY(30)="Y"
 ;
QUIT D KVA^VADPT
 D MAKEIT^VAFHLU("PID",.VAFY,.OUTPUT,.VAFPID)
 Q OUTPUT
 ;
ADDR(VAFADDR,VAFCOUNT) ;Return HL7 address
 ; Input  - VAFADDR as address in format:
 ;            line1^line2^line3^city^state^zip+4
 ;          VAFCOUNT as internal value of county (optional)
 ; Output - HL7 v2.3 formatted Address_HLFS_County Code
 ;
 ;      ****Also assumes all HL7 variables returned from****
 ;          INIT^HLTRANS are defined
 ;
 N X,Y,Z S X=$E(HLECH)
 ;Street address (line 1)
 S $P(Y,X,1)=$P(VAFADDR,"^",1)
 ;Other designation (line 2)
 S $P(Y,X,2)=$P(VAFADDR,"^",2)
 ;City
 S $P(Y,X,3)=$P(VAFADDR,"^",4)
 ;State
 S $P(Y,X,4)=$P($G(^DIC(5,+$P(VAFADDR,"^",5),0)),"^",2)
 ;Zip
 S $P(Y,X,5)=$P(VAFADDR,"^",6)
 ;Other geographic designation (line 3)
 S $P(Y,X,8)=$P(VAFADDR,"^",3)
 ;County
 S $P(Y,X,9)=$P($G(^DIC(5,+$P(VAFADDR,"^",5),1,+$G(VAFCOUNT),0)),"^",3)
 F Z=1,2,3,4,5,8,9 I $P(Y,X,Z)="" S $P(Y,X,Z)=HLQ
 I $G(VAFCOUNT) D
 .S $P(Y,HLFS,2)=$P(Y,X,9)
 Q Y
