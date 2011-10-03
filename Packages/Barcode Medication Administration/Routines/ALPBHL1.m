ALPBHL1 ;OIFO-DALLAS MW,SED,KC - BCBU main HL7 message processor ;01/01/03
 ;;3.0;BAR CODE MED ADMIN;**7,8**;Mar 2004
 ;
 S ALPBECH=HL("ECH")
 S ALPBCS=$E(ALPBECH)
 S ALPBFS=HL("FS")
 S ALPBHREC=$S(+$G(HLMTIEN)>0:HLMTIEN,1:$G(HL("MID")))
 ;
 ; process the entire HL7 message's lines into local array...
 F I=1:1 X HLNEXT Q:+$G(HLQUIT)'>0  D
 .S ALPBSEG=$P(HLNODE,ALPBFS,1)
 .; store patient ID and order segments in a special way...
 .I ALPBSEG="PID"!(ALPBSEG="ORC")!(ALPBSEG="PV1")!(ALPBSEG="RXO") S ALPBMTXT(ALPBSEG)=HLNODE
 .I ALPBSEG="AL1" S ALPBMTXT("AL1")=1
 .S ALPBMTXT(I)=HLNODE
 .; get any continuation lines...
 .S J=0
 .F  S J=$O(HLNODE(J)) Q:'J  S ALPBMTXT(I,J)=HLNODE(J)
 .K ALPBSEG
 ;
 ; retrieve patient ID data from the PID segment...
 S ALPBX=$G(ALPBMTXT("PID"))
 I ALPBX'="" D
 .D GETPID^ALPBUTL2(ALPBX,ALPBFS,ALPBCS,ALPBECH,.ALPBDATA)
 .S ALPBPDFN=$G(ALPBDATA(1))
 .S ALPBPNAM=$G(ALPBDATA(2))
 .S ALPBPSSN=$G(ALPBDATA(3))
 .S ALPBPDOB=$G(ALPBDATA(4))
 .S ALPBPSEX=$G(ALPBDATA(5))
 .K ALPBDATA
 K ALPBX
 ; we must have patient's SSN (ALPBPSSN) to process this message...
 I $G(ALPBPSSN)="" D  Q
 .D ERRBLD^ALPBUTL1("PID","Invalid/missing SSN",.ALPBFERR)
 .D ERRLOG^ALPBUTL1(0,0,ALPBHREC,"PID",$G(ALPBMTXT("PID"),"PID segment undefined"),.ALPBFERR)
 .K ALPBFERR
 .D CLEAN
 K ALPBMTXT("PID")
 ;
 ; using patient's DFN, get BCBU record number...
 S ALPBIEN=0
 I $D(^ALPB(53.7,ALPBPDFN)) S ALPBIEN=ALPBPDFN
 ; create new record?...
 I ALPBIEN'>0 D
 .S DIC="^ALPB(53.7,"
 .S DIC(0)="LZ"
 .S DINUM=ALPBPDFN
 .S DLAYGO=53.7
 .S X=ALPBPNAM
 .D FILE^DICN
 .K DIC,DINUM,DLAYGO
 .S ALPBIEN=+Y
 ; if ALPBIEN'>0 then patient record find or creation error...
 I +ALPBIEN'>0 D  Q
 .D ERRBLD^ALPBUTL1("","Failed to find/create patient record",.ALPBFERR)
 .D ERRLOG^ALPBUTL1(0,0,ALPBHREC,"",$G(ALPBPDFN,"DFN undefined")_"^"_$G(ALPBPNAM,"Name undefined")_"^"_$G(ALPBPSSN,"SSN undefined"),.ALPBFERR)
 .K ALPBFERR
 .D CLEAN
 ;
 ; check PV1 segment to see if this is a discharge movement.  if so,
 ; delete the patient's BCBU record and quit...
 I $P($G(ALPBMTXT("PV1")),ALPBFS,37)'="" D  Q
 .D DELPT^ALPBUTL(+$G(ALPBIEN))
 .D CLEAN
 ;
 ; file/update patient demographic data...
 S ALPBFILE(53.7,ALPBIEN_",",.01)=ALPBPNAM
 S ALPBFILE(53.7,ALPBIEN_",",1)=ALPBPSSN
 S ALPBFILE(53.7,ALPBIEN_",",2)=ALPBPDOB
 S ALPBFILE(53.7,ALPBIEN_",",3)=ALPBPSEX
 D FILE^DIE("","ALPBFILE","ALPBFERR")
 I +$G(ALPBFERR("DIERR")) D ERRLOG^ALPBUTL1(+$G(ALPBIEN),0,$G(ALPBHREC),"PID","Demographics update failed",.ALPBFERR)
 K ALPBFERR,ALPBFILE
 ;
 ; if the allergies flag is set (ALPBMTXT("AL1")), delete any
 ; allergies on file (they will be rebuilt by this message)...
 I +$G(ALPBMTXT("AL1")) D DELALG^ALPBUTL2(ALPBIEN)
 ;
 ; if there is no ORC (order) segment, process the rest of the
 ; message and quit...
 I $G(ALPBMTXT("ORC"))="" D PM Q
 ;
 ; retrieve order number and transaction date from ORC segment...
 D GETORC^ALPBUTL2($G(ALPBMTXT("ORC")),$G(ALPBFS),$G(ALPBCS),.ALPBDATA)
 S ALPBMLOG=$S($G(ALPBDATA(0))="ML":1,1:0)
 S ALPBORDN=$G(ALPBDATA(1))
 S ALPBORDT=$G(ALPBDATA(2))
 S ALPBORDC=+$G(ALPBDATA(3))
 ; ALPBOTYP="V" for IV, "U" for Unit Dose, or "P" for Pending
 S ALPBOTYP=$G(ALPBDATA(4))
 K ALPBDATA
 ;
 ; we must have an order number to process the order-specific data,
 ; if we do not then log that error condition and quit...
 I $G(ALPBORDN)="" D  Q
 .D ERRBLD^ALPBUTL1("","No order number in ORC segment",.ALPBFERR)
 .D ERRLOG^ALPBUTL1(0,0,ALPBHREC,"ORC",$G(ALPBMTXT("ORC"),"ORC segment not defined"),.ALPBFERR)
 .K ALPBFERR
 .D CLEAN
 K ALPBMTXT("ORC")
 ;
 ; using CPRS order number, check to see if the order is already on
 ; file.  if so, and status is PENDING delete the order record...
 I ALPBORDC>0 D
 .;LOOP Through. May have replaced orders so need to check all
 .S ALPBI=0
 .F  S ALPBI=$O(^ALPB(53.7,ALPBIEN,2,"ACPRS",ALPBORDC,ALPBI)) Q:+ALPBI'>0  D
 ..I $E($P($G(^ALPB(53.7,ALPBIEN,2,ALPBI,0)),"^",3),1,2)'="IP" Q
 ..D DELORD^ALPBUTL(ALPBIEN,ALPBI)
 K ALPBI
 ;
 ; existing order's record number?...
 K ALPBOIEN
 S ALPBOIEN=+$O(^ALPB(53.7,ALPBIEN,2,"B",ALPBORDN,0))
 ; if this isn't a Med Log update, and this order is already on
 ; file, delete its drug(s), additive(s) and/or solution(s) --
 ; they will be rebuilt by the other segments in this message...
 I +$G(ALPBMLOG)=0&(ALPBOIEN>0) D CLORD^ALPBUTL2(ALPBIEN,ALPBOIEN)
 ; create new order record?...
 I +$G(ALPBOIEN)=0 D
 .S ALPBOIEN=+$O(^ALPB(53.7,ALPBIEN,2," "),-1)+1
 .S ALPBFILE(53.702,"+"_ALPBOIEN_","_ALPBIEN_",",.01)=ALPBORDN
 .; don't file a 0 (zero) CPRS order number...
 .I ALPBORDC>0 S ALPBFILE(53.702,"+"_ALPBOIEN_","_ALPBIEN_",",1)=ALPBORDC
 .S ALPBFILE(53.702,"+"_ALPBOIEN_","_ALPBIEN_",",3)=ALPBORDT
 .S ALPBFILE(53.702,"+"_ALPBOIEN_","_ALPBIEN_",",6)=ALPBOTYP
 .D UPDATE^DIE("","ALPBFILE","ALPBOIEN","ALPBFERR")
 .I +$G(ALPBFERR("DIERR")) D ERRLOG^ALPBUTL1(ALPBIEN,"0",ALPBHREC,"NEWORD","",.ALPBFERR)
 .K ALPBFERR,ALPBFILE
 ;
PM ; process the message segments...
 S I=0
 F  S I=$O(ALPBMTXT(I)) Q:'I  D
 .S ALPBDATA=ALPBMTXT(I)
 .S ALPBSEG=$P(ALPBDATA,ALPBFS)
 .; allergies segment...
 .I ALPBSEG="AL1" D
 ..D AL1^ALPBHL1U(+$G(ALPBIEN),$G(ALPBDATA),$G(ALPBFS),$G(ALPBCS),.ALPBFERR)
 ..I +$G(ALPBFERR("DIERR")) D ERRLOG^ALPBUTL1(+$G(ALPBIEN),+$G(ALPBOIEN),$G(ALPBHREC),"AL1",$G(ALPBDATA),.ALPBFERR)
 ..K ALPBFERR
 .; general order segment...
 .I ALPBSEG="ORC" D
 ..D ORC^ALPBHL1U(+$G(ALPBIEN),+$G(ALPBOIEN),$G(ALPBDATA),$G(ALPBMLOG),$G(ALPBFS),$G(ALPBCS),.ALPBFERR)
 ..I +$G(ALPBFERR("DIERR")) D ERRLOG^ALPBUTL1(+$G(ALPBIEN),+$G(ALPBOIEN),$G(ALPBHREC),"ORC",$G(ALPBDATA),.ALPBFERR)
 ..K ALPBFERR
 .; patient movement/location segment...
 .I ALPBSEG="PV1" D
 ..D PV1^ALPBHL1U(+$G(ALPBIEN),$G(ALPBDATA),$G(ALPBFS),$G(ALPBCS),.ALPBFERR)
 ..I +$G(ALPBFERR("DIERR")) D ERRLOG^ALPBUTL1(+$G(ALPBIEN),+$G(ALPBOIEN),$G(ALPBHREC),"PV1",$G(ALPBDATA),.ALPBFERR)
 ..K ALPBFERR
 .; IV orders segment...
 .I ALPBSEG="RXC" D
 ..D RXC^ALPBHL1U(+$G(ALPBIEN),+$G(ALPBOIEN),$G(ALPBDATA),$G(ALPBFS),$G(ALPBCS),.ALPBFERR)
 ..I +$G(ALPBFERR("DIERR")) D ERRLOG^ALPBUTL1(+$G(ALPBIEN),+$G(ALPBOIEN),$G(ALPBHREC),"RXC",$G(ALPBDATA),.ALPBFERR)
 ..K ALPBFERR
 .; drug, additives and/or solutions segment...
 .I ALPBSEG="RXE" D
 ..I $G(ALPBDATA)="" Q
 ..; if this is a Pending order, check to see if a drug is included in this RXE seg.  if not, let's try to add the one that may be in the RXO seg...
 ..I +$P($P(ALPBDATA,ALPBFS,3),ALPBCS,4)=0 S $P(ALPBDATA,ALPBFS,3)=$P($G(ALPBMTXT("RXO")),ALPBFS,2)
 ..;chech for any continuation lines
 ..S J=0 F  S J=$O(ALPBMTXT(I,J)) Q:'J  S ALPBDATA=ALPBDATA_ALPBMTXT(I,J)
 ..D RXE^ALPBHL1U(+$G(ALPBIEN),+$G(ALPBOIEN),ALPBDATA,$G(ALPBFS),$G(ALPBCS),$G(ALPBECH),.ALPBFERR)
 ..I +$G(ALPBFERR("DIERR")) D ERRLOG^ALPBUTL1(+$G(ALPBIEN),+$G(ALPBOIEN),$G(ALPBHREC),"RXE",ALPBDATA,.ALPBFERR)
 ..K ALPBFERR
 .; med route...
 .I ALPBSEG="RXR" D
 ..D RXR^ALPBHL1U(+$G(ALPBIEN),+$G(ALPBOIEN),$G(ALPBDATA),$G(ALPBFS),$G(ALPBCS),.ALBPFERR)
 ..I +$G(ALPBFERR("DIERR")) D ERRLOG^ALPBUTL1(+$G(ALPBIEN),+$G(ALPBOIEN),$G(ALPBHREC),"RXR",$G(ALPBDATA),.ALPBFERR)
 ..K ALPBFERR
 .; provider comments, special instructions or other print info...
 .I ALPBSEG="NTE" D
 ..; NTE segments can be multiple-lines.  set up an array (ALPBNTE(...)) to pass to the filer...
 ..; the first node will be the one that contains the NTE segment identifier
 ..S ALPBNTE(1)=ALPBDATA
 ..S ALPBX=1
 ..; loop from ALPBMTXT(I) to retrieve any continuation lines...
 ..S J=0
 ..F  S J=$O(ALPBMTXT(I,J)) Q:'J  D
 ...S ALPBX=ALPBX+1
 ...S ALPBNTE(ALPBX)=ALPBMTXT(I,J)
 ..K ALPBX,J
 ..D NTE^ALPBHL1U(+$G(ALPBIEN),+$G(ALPBOIEN),.ALPBNTE,$G(ALPBFS),$G(ALPBCS),.ALPBFERR)
 ..I +$G(ALPBFERR("DIERR")) D ERRLOG^ALPBUTL1(+$G(ALPBIEN),+$G(ALPBOIEN),$G(ALPBHREC),"NTE",ALPBDATA,.ALPBFERR)
 ..K ALPBFERR,ALPBNTE
 .K ALPBDATA,ALPBSEG
 ;
 ; set RECORD LAST UPDATED field...
 S ALPBLUPD=$$NOW^XLFDT()
 I $G(^ALPB(53.7,+$G(ALPBIEN),0))'="" D
 .S ALPBFILE(53.7,ALPBIEN_",",7)=ALPBLUPD
 .D FILE^DIE("","ALPBFILE","ALPBFERR")
 .K ALPBFERR,ALPBFILE
 ;
 ; update PARAMETER file with last update date...
 S ALPBPARM=+$O(^ALPB(53.71,0))
 I ALPBPARM>0 D
 .S ALPBFILE(53.71,ALPBPARM_",",4)=ALPBLUPD
 .D FILE^DIE("","ALPBFILE","ALPBFERR")
 .K ALPBFERR,ALPBFILE
 K ALPBLUPD,ALPBPARM
 ;
CLEAN K ALPBCS,ALPBDATA,ALPBECH,ALPBFS,ALPBHREC,ALPBIEN,ALPBMLOG,ALPBMTXT
 K ALPBOIEN,ALPBORDC,ALPBORDN,ALPBORDT,ALPBOTYP,ALPBPDFN,ALPBPDOB
 K ALPBPNAM,ALPBPSEX,ALPBPSSN,ALPBSEG
 Q
