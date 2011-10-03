VBECDCHX ;hoifo/gjc-data conversion & pre-implementation;Nov 21, 2002
 ;;5.2;LAB SERVICE;**335**;Sep 27, 1994;Build 5
 ;
 ;Medical Device #:
 ;Note: The food and Drug Administration classifies this software as a
 ;medical device.  As such, it may not be changed in any way.
 ;Modifications to this software may result in an adulterated medical
 ;device under 21CFR820, the use of which is considered to be a
 ;violation of US Federal Statutes.  Acquiring and implementing this
 ;software through the Freedom of Information Act requires the
 ;implementer to assume total responsibility for the software, and
 ;become a registered manufacturer of a medical device, subject to FDA
 ;regulations.
 ;
 ;Call to $$ROOT^DILFD is supported by IA: 2055
 ;
 ; This routine is called from the main data conversion software
 ; (VBECDC01).  This routine checks if antigen/antibody, transfusion
 ; reaction, blood product, or blood supplier data has been edited
 ; or deleted from the legacy VistA Blood Bank files.  I do not check
 ; for added data to the legacy VistA Blood Bank files; other options
 ; within the software exist for this purpose.
 ;
 ;  input: no data input into this module
 ; return: VBECFLG - 1 if a discrepancy exists, else 0
 ; check the data, all of this is run real-time (no queuing)
 ;
 ; variable definitions:
 ; CNT-counter, used to print '.' every 100 records
 ; VBEC01-'file-ien' or 'file' data (.01 field on file 6005)
 ; VBECDA-record ien file 6005
 ; VBECDATA-antigen/antibody, trans. react., blood prod., blood supplier
 ; VBECFILE-file number of legacy data
 ; VBECFLG-indicates if data is valid across files/sub-file:
 ;         61.3, 65.4, & 6005 (1 for no, 0 for yes)
 ; VBECGUID-only checking data that has been mapped
 ; VBECIEN-record ien (.01 field, file 6005 2nd piece delimited by '-')
 ;         (not applicable on blood supplier data)
 ; VBECL0-legacy file (#s 61.3, or 65.4) zero node
 ; VBECLCX-checksum for a data record, legacy file (#s 61.3 & 65.4)
 ; VBECLID-identifier on legacy file
 ; VBECLNM-name of record in legacy file
 ; VBECLTOT-checksum value for legacy data (name and identifier)
 ; VBECRT-legacy file data global. in all cases: ^LAB(File#
 ; VBECSTR-temporary string data, holding variable
 ; VBECT0-transitory file (# 6005) zero node
 ; VBECTCX-checksum for a data record, transitory file (# 6005)
 ; VBECTID-identifier on  transitory file
 ; VBECTNM-name of record in transitory file
 ; VBECTTOT-checksum value for transitory data (name and identifier)
 ;
EN() ; Main entry point to check if mapped data remains consistent with
 ; data from the parent (61.3 & 65.4) files.  If not, do not
 ; proceed with the data conversion (VBECDC01).
 ;
 W @IOF N CNT,VBECFLG S (CNT,VBECFLG)=0 ;assume successful test
 ;check the antigen/antibody data first
 F VBECFILE=61.3,65.4 D  Q:VBECFLG
 .S VBEC01=VBECFILE,VBECRT=$$ROOT^DILFD(VBEC01,"",1)
 .S VBECDATA=$S(VBECFILE="61.3":"Antibody/Antigen",VBECFILE="65.4":"Transfusion Reaction",VBECFILE="66":"Blood Product",1:"Blood Supplier")
 .W !,"Checking the integrity of "_VBECDATA_" data.",!,"'*' indicates truncated data (65 chars max)."
 .;obtain the GUID.  Only checking mapped data
 .S VBECGUID=""
 .F  S VBECGUID=$O(^VBEC(6005,"AB",VBEC01,VBECGUID)) Q:VBECGUID=""  D  Q:VBECFLG=1
 ..S VBECDA=+$O(^VBEC(6005,"AB",VBEC01,VBECGUID,0)) Q:'VBECDA  ;ien
 ..;
 ..;must have data on the node
 ..S VBECT0=$G(^VBEC(6005,VBECDA,0)) Q:VBECT0=""
 ..;
 ..S VBECIEN=+$P($P(VBECT0,U),"-",2) Q:'VBECIEN
 ..;
 ..;obtain .01 field value and identifier
 ..S VBECSTR=$$FILEIEN(VBECRT,VBECIEN)
 ..S VBECLNM=$P(VBECSTR,U),VBECLID=$P(VBECSTR,U,2)
 ..;
 ..;compare the checksums of the data between the parent files (61.3
 ..;& 65.4) against the mapped data in file 6005 
 ..S VBECTNM=$P(VBECT0,U,2),VBECTID=$P(VBECT0,U,3)
 ..S VBECLTOT=$$CHECKSUM^VBECDCU2(VBECLNM)+$$CHECKSUM^VBECDCU2(VBECLID)
 ..S VBECTTOT=$$CHECKSUM^VBECDCU2(VBECTNM)+$$CHECKSUM^VBECDCU2(VBECTID)
 ..I VBECLTOT'=VBECTTOT S VBECFLG=1 D
 ...;
 ...;display the discrepancies to the user
 ...W !,"Legacy NAME: "_VBECLNM
 ...W !,"Mapped NAME: "_VBECTNM
 ...W !,"Legacy ID: "_$E(VBECLID,1,65)_$S($L(VBECLID)>65:"*",1:"")
 ...W !,"Mapped ID: "_$E(VBECTID,1,65)_$S($L(VBECTID)>65:"*",1:"")
 ...Q
 ..S CNT=CNT+1 W:'(CNT#100) "."
 ..Q
 .Q
 ;
KILL ; kill and quit
 K VBEC01,VBECDA,VBECDATA,VBECFILE,VBECGUID,VBECL0,VBECLCX,VBECLID
 K VBECLNM,VBECLTOT,VBECRT,VBECT0,VBECTCX,VBECTTOT
 Q VBECFLG
 ;
FILEIEN(VBECRT,VBECIEN) ; For records tracking the parent file and record ien,
 ; define the NAME and ID values here.  Note ID values reside on
 ; different pieces for different files.
 ; Antibody/Antigen data resides in: ^LAB(61.3,
 ; Transfusion Reaction data resides in: ^LAB(65.4,
 ; input: VBECIEN-ien of the record in question
 ;        VBECRT-file root of the data global
 ;        Note: VBECFILE is of a global scope
 ; return: VBECSTR-delimited string: NAME^ID (optional)
 N VBECL0,VBECPCE S VBECL0=$G(@VBECRT@(VBECIEN,0)) Q:VBECL0="" ""
 ;
 ; VBECPCE is the SNOMED code for antibody/antigen data or the full name
 ; of our transfusion reaction.
 ; If data changes on the VistA side (name or required identifier value)
 ; the data conversion will not proceed.
 ;
 S VBECPCE=$S(VBECFILE=61.3:2,1:3) ;note origin of data
 Q $P(VBECL0,U)_"^"_$P(VBECL0,U,VBECPCE)
 ;
