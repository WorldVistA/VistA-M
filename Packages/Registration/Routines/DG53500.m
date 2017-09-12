DG53500 ;BPFO/JRP - POST INIT FOR PATCH 500 ;3/12/2003
 ;;5.3;Registration;**500**;Aug 13, 1993
 ;
POST ;Entry point for patch DG*5.3*500 post init
 N DFN,PTR10,GOODPTR,NODE,TMP,DGFDA,DGMSG,COUNT,DGRUGA08,VAFCA08
 ;Initialize list of good pointers to RACE file (#10)
 D BMES^XPDUTL("Initializing list of good pointers to RACE file (#10)")
 S PTR10=0
 F  S PTR10=+$O(^DIC(10,PTR10)) Q:'PTR10  D
 .S NODE=$G(^DIC(10,PTR10,0))
 .S TMP=$P(NODE,"^",2)
 .I TMP?1N S:((TMP>0)&(TMP<8)) GOODPTR(PTR10)=""
 ;Scan PATIENT file (#2) for bad entries in RACE field (#.06)
 K DGMSG
 S DGMSG(1)=" "
 S DGMSG(2)="Scanning PATIENT file (#2) for entries in RACE field (#.06) that"
 S DGMSG(3)="are not valid.  Every 1000th DFN checked will be printed."
 S DGMSG(4)=" "
 D MES^XPDUTL(.DGMSG) K DGMSG
 ;Don't generate ADT & RAI/MDS HL7 messages
 S (VAFCA08,DGRUGA08)=1
 I $G(XPDNM)'="" S XPDIDTOT=$O(^DPT("A"),-1) D UPDATE^XPDID(0)
 S DFN=0
 F COUNT=1:1 S DFN=$O(^DPT(DFN)) Q:'DFN  D
 .;Display progress
 .I '(COUNT#1000) D
 ..K TMP
 ..S TMP="Current DFN: "_DFN_"                    "
 ..S TMP=$E(TMP,1,30)_"Total checked: "_$FN(COUNT,",")
 ..D MES^XPDUTL(TMP) K TMP
 ..D:($G(XPDNM)'="") UPDATE^XPDID(DFN)
 .S NODE=$G(^DPT(DFN,0))
 .S PTR10=$P(NODE,"^",6)
 .Q:(PTR10="")
 .;Not a good pointer - delete value
 .I '$D(GOODPTR(PTR10)) D
 ..K DGFDA,DGMSG
 ..S DGFDA(2,DFN_",",.06)="@"
 ..D FILE^DIE("","DGFDA","DGMSG")
 Q
