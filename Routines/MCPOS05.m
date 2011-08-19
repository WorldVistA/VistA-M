MCPOS05 ;HIRMFO/DAD-MAIL GROUP CREATION ;6/4/96  11:21
 ;;2.3;Medicine;;09/13/1996
 ;
 N DA,DIE,DR,MCA,MCB,MCC,MCD,MCE,MCF,MCG,MCDATA
 S MCDATA(1)=""
 S MCDATA(2)="Creating the MC MESSAGING SERVER mail group."
 D MES^XPDUTL(.MCDATA) K MCDATA
 ;
 S MCA="MC MESSAGING SERVER" ; Mail group name
 S MCB=0 ; Public
 S MCC=.5 ; Organizer is Postmaster
 S MCD=0 ; No self enrollment
 S MCF(1)="Mail group used for Medicine HL7 messages." ; Description
 S MCG=1 ; Silent flag
 S MCDATA=$$MG^XMBGRP(MCA,MCB,MCC,MCD,.MCE,.MCF,MCG)
 I MCDATA D
 . S MCE(3.812,"?+1,"_MCDATA_",",.01)="S.MCHL7SERVER@"_^XMB("NETNAME")
 . D UPDATE^DIE("E","MCE")
 . Q
 Q
