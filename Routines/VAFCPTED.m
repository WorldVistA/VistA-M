VAFCPTED ;ISA/RJS,Zoltan-EDIT EXISTING PATIENT ;04/06/99
 ;;5.3;Registration;**149,333,756**;Aug 13, 1993;Build 5
EDIT(DGDFN,ARRAY,STRNGDR) ;-- Edits existing patient
 ;Input:
 ;  DGDFN - IEN in the PATIENT (#2) file
 ;  ARRAY - Array containing fields to be edited.
 ;          Ex. ARRAY(.111)="123 STREET" or ARRAY(2,.111)="123...
 ;  STRNGDR - String of delimited PATIENT (#2) file fields in the order 
 ;            in which the fields will be processed by DIE.
 ;            Ex. ".01;.03;.05..."
 ;Output:
 ;  No output
 ;
 S U="^"
 N LOCKFLE,FLD,ZTQUEUED,DIQUIET,OLDZIP,VAFCX,STRNG
 S (ZTQUEUED,DIQUIET)=1
 L +^DPT(DGDFN):60
 S LOCKFLE=$T ; Need to remember whether the lock went through.
 I $L($G(@ARRAY@(.1112)))=5 D
 . ; This section prevents a 5-digit ZIP from replacing
 . ; an otherwise equivalent ZIP+4.
 . S OLDZIP=$$GET1^DIQ(2,DGDFN_",",.1112,"I")
 . I $E(OLDZIP,1,5)=@ARRAY@(.1112) S @ARRAY@(.1112)=OLDZIP
 ;process the given PATIENT file DR string in the given order
 S STRNG=STRNGDR F VAFCX=1:1 Q:STRNG=""  S FLD=$P(STRNGDR,";",VAFCX) S STRNG=$P(STRNGDR,";",VAFCX+1,$L(STRNGDR,";")) D LOAD
 ;
 ;Do Address Bulletin if incoming Address does not equal existing
 ;Address - removed bulletin with patch DG*5.3*333
 ;
 ;I $D(@ARRAY@(.111))!$D(@ARRAY@(.112))!$D(@ARRAY@(.113))!$D(@ARRAY@(.114))!$D(@ARRAY@(.115))!$D(@ARRAY@(.117))!$D(@ARRAY@(.1112)) D  ;**333
 ;. D ADDRESS^RGRSBULL(DGDFN,$G(@ARRAY@(.01)),$G(@ARRAY@(.111)),$G(@ARRAY@(.112)),$G(@ARRAY@(.113)),@ARRAY@("SENDING SITE"),$G(@ARRAY@(.114)),$G(@ARRAY@(.117)),$G(@ARRAY@(.115)),$G(@ARRAY@(.1112)))
 ;
 I LOCKFLE L -^DPT(DGDFN)
 ;
 K DIE,DA
 Q
 ;
LOAD ; -- Loads fields to patient file
 N DR,DIE
 ;**756 check if updating ALIAS
 I FLD=1 D ALIAS Q
 S DA=DGDFN,DIE="^DPT("
 I $G(@ARRAY@(FLD))="" Q
 I $G(@ARRAY@(FLD))["@" S @ARRAY@(FLD)="@"
 ;GENERATE BULLETIN FOR CONDITION BELOW ?
 I $G(@ARRAY@(FLD))[U Q
 S DR=FLD_"///^S X=$G(@ARRAY@(FLD))"
 D ^DIE
 Q
 ;
ALIAS ; update Alias multiple **756
 ;allow the synchronizing of the Alias multiple with the data passed in the array
 ;array(1,x)=name (last, first middle suffix format)^ssn
 N HAVE,I,MIEN,ADD,DONE,FDA,MPIFERR,DEL,ALIAS,CNT
 M HAVE=^DPT(DGDFN,.01)
 S CNT=0
 ;see if any need to be added
 S I=0 F  S I=$O(@ARRAY@(1,I)) Q:'I  D  ;loop through incoming data
 . S ADD=1,(DONE,MIEN)=0 F  S MIEN=$O(HAVE(MIEN)) Q:'MIEN  D  I DONE Q  ;loop through existing data
 ..I $P(@ARRAY@(1,I),"^",1,2)=$P($G(HAVE(MIEN,0)),"^",1,2) S ADD=0,DONE=1 Q  ;compare to existing data to see if already in subfile, if not then
 .I ADD S ALIAS=@ARRAY@(1,I) D  ;add new entry to subfile
 ..S FDA(2.01,"+"_I_","_DGDFN_",",.01)=$P(@ARRAY@(1,I),"^")
 ..S FDA(2.01,"+"_I_","_DGDFN_",",1)=$P(@ARRAY@(1,I),"^",2)
 I $D(FDA) D UPDATE^DIE("E","FDA",,"MPIFERR") I $G(MPIFERR("DIERR",1,"TEXT",1))'="" S RGER="-1^"_MPIFERR("DIERR",1,"TEXT",1)
 ;delete entries
 K FDA,MPIFERR
 S MIEN=0 F  S MIEN=$O(HAVE(MIEN)) Q:'MIEN  D  ;loop through existing data
 . S DEL=1,(DONE,I)=0 F  S I=$O(@ARRAY@(1,I)) Q:'I  D  I DONE Q  ;loop through incoming data
 . . I $P($G(HAVE(MIEN,0)),"^",1,2)=$P(@ARRAY@(1,I),"^",1,2) S DEL=0,DONE=1 Q  ;compare to existing data to see if data should be deleted
 . I DEL S FDA(2.01,MIEN_","_DGDFN_",",.01)="@" ;existing entry to delete
 I $D(FDA) D FILE^DIE("E","FDA","MPIERR") I $G(MPIFERR("DIERR",1,"TEXT",1))'=""  S RGER="-1^"_MPIFERR("DIERR",1,"TEXT",1) ;delete entry
 Q
