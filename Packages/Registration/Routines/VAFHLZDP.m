VAFHLZDP ;ALB/MLI,TDM - Creates HL7 segments ZDP and/or ZIC ; 1/21/09 3:49pm
 ;;5.3;Registration;**33,653,688,754**;Aug 13, 1993;Build 46
 ;
 ; This routine will return the ZDP (dependent) segment for the
 ; dependent specified by the variable VAFIEN.
 ;
EN(VAFIEN,VAFSTR,VAFNUM,VAFMTDT,VAFIADT) ; Call to produce ZDP segment for given individual
 ;
 ;
 ;  Input:  VAFIEN   as IEN of PATIENT RELATION (#408.12) file
 ;          VAFSTR   as string of desired fields separated by commas
 ;          VAFNUM   as the number desired for the set id (default = 1)
 ;          VAFMTDT  as the date of the means test (default = DT)
 ;          VAFIADT  as spouse/dependent inactivation date (optional)
 ;
 ; Output:  String of fields forming HL7 ZDP segment
 ;
 N NODE,NODE0,X,VAFY,NODE1,CS,SS,RS
 S CS=$E(HLECH,1),SS=$E(HLECH,4),RS=$E(HLECH,2)
 S NODE=$$DEM^DGMTU1(+$G(VAFIEN)),NODE1=$$NODE1(+$G(VAFIEN))
 I $G(VAFSTR)']"" G QUIT
 S $P(VAFY,HLFS,14)="",VAFSTR=","_VAFSTR_","
 S $P(VAFY,HLFS,1)=$S($G(VAFNUM):VAFNUM,1:1)
 S VAFMTDT=$S($G(VAFMTDT):VAFMTDT,1:DT)
 I VAFSTR[",2," S X=$$HLNAME^HLFNC($P(NODE,"^",1)),$P(VAFY,HLFS,2)=$S(X]"":X,1:HLQ) ; name
 I VAFSTR[",3," S $P(VAFY,HLFS,3)=$S($P(NODE,"^",2)]"":$P(NODE,"^",2),1:HLQ) ; sex
 I VAFSTR[",4," S X=$$HLDATE^HLFNC($P(NODE,"^",3)),$P(VAFY,HLFS,4)=$S(X]"":X,1:HLQ) ; dob
 I VAFSTR[",5," S $P(VAFY,HLFS,5)=$S($P(NODE,"^",9)]"":$P(NODE,"^",9),1:HLQ) ; ssn
 I VAFSTR[",6," D
 .S NODE0=$G(^DGPR(408.12,+$G(VAFIEN),0))
 .S $P(VAFY,HLFS,6)=$S($P(NODE0,"^",2)]"":$P(NODE0,"^",2),1:HLQ) ; relationship to patient
 I VAFSTR[",7," S $P(VAFY,HLFS,7)=+$G(VAFIEN) ; internal entry number
 I VAFSTR[",8,",$$REL^DGMTU1(VAFIEN)="SPOUSE" D
 .S $P(VAFY,HLFS,8)=$S($P(NODE1,"^")]"":$P(NODE1,"^"),1:HLQ) ; spouse's maiden name
 I VAFSTR[",9," D
 .S X=-($E(VAFMTDT,1,3)-1_"1231.9"),X=-$O(^DGPR(408.12,+$G(VAFIEN),"E","AID",X))
 .S X=$$HLDATE^HLFNC(X),$P(VAFY,HLFS,9)=$S(X]"":X,1:HLQ) ; effective date
 I VAFSTR[",10," S $P(VAFY,HLFS,10)=$S($P(NODE,"^",10)]"":$P(NODE,"^",10),1:HLQ) ; pseudo ssn reason
 I VAFSTR[",11," S X=$$HLDATE^HLFNC($G(VAFIADT)),$P(VAFY,HLFS,11)=$S(X]"":X,1:HLQ) ; inactivation date
 I VAFSTR[",13," D       ; Address
 .S X=$$HLADDR^HLFNC($P(NODE1,"^",2,3),$P(NODE1,"^",5,7))
 .I $P(X,CS)="" S $P(VAFY,HLFS,13)=HLQ Q    ;Must have Addr Line 1
 .S $P(X,CS,6)="",$P(X,CS,7)="P",$P(X,CS,8)=$P(NODE1,"^",4)
 .S $P(X,CS,12)=$$HLDATE^HLFNC($P(NODE1,"^",9))
 .S $P(VAFY,HLFS,13)=X
 I VAFSTR[",14," D       ; Telephone
 .S X=$$HLPHONE^HLFNC($P(NODE1,"^",8))
 .I X="" S $P(VAFY,HLFS,14)=HLQ Q
 .S $P(VAFY,HLFS,14)=X_CS_"PRN"_CS_"PH"
 ;
QUIT Q "ZDP"_HLFS_$G(VAFY)
 ;
NODE1(DGPRI) ;GET Node 1 of Patient Relation
 N DGVPI,DGVP1
 S DGVPI=$P($G(^DGPR(408.12,DGPRI,0)),"^",3)
 I DGVPI]"" S DGVP1=$G(@("^"_$P(DGVPI,";",2)_+DGVPI_",1)"))
 Q $S($G(DGVP1)]"":DGVP1,1:"")
