XULMLD ;IRMFO-ALB/CJM/SWO/RGG - KERNEL LOCK MANAGER ;08/28/2012
 ;;8.0;KERNEL;**608**;JUL 10, 1995;Build 84
 ;;Per VA Directive 6402, this routine should not be modified
 ;
 ;  ******************************************************************
 ;  *                                                                *
 ;  *  The Kernel Lock Manager is based on the VistA Lock Manager    *
 ;  *        developed by Tommy Martin.                              *
 ;  *                                                                *
 ;  ******************************************************************
 ;
 ;
 ;Contains routines that derive information from a lock by using
 ;the LOCK DICTIONARY
 ;
FIND(LOCK,FILES,XULMVAR) ;
 ;Description:  This function finds a match to the LOCK in the lock
 ;dictionary.  If successful it returns the ien of the lock template,
 ;0 otherwise.
 ;
 ;Input:
 ;   LOCK - an entry in the lock table
 ;Output:
 ;   function returns the ien of the matching lock template, 0 otherwise
 ;   FILES (pass-by-reference) a list of files that can be referenced
 ;                             by LOCK. Subscripts are:
 ;           (<file #>)=<ien of the entry in FILE REFERENCES multip>
 ;   XULMVAR (pass-by-references) list of variables found within the lock
 ;                                template.  Subscripts are:
 ;           (<variable name>)=<value>
 ;
 N TEMPLATE,VAR,MATCH,VARS
 S (MATCH,TEMPLATE)=0
 S VAR=$P(LOCK,"(")
 S VAR=$O(^XLM(8993,"AC",VAR),-1)
 F  S VAR=$O(^XLM(8993,"AC",VAR)) Q:VAR'=$P(LOCK,"(")  D  Q:TEMPLATE
 .S TEMPLATE=0
 .F  S TEMPLATE=$O(^XLM(8993,"AC",VAR,TEMPLATE)) Q:'TEMPLATE  Q:$$MATCH(LOCK,TEMPLATE,.FILES,.VARS)
 .;
 .;If no full match, check for allowable partial match
 .I 'TEMPLATE D
 ..N PARTS,PCOUNT,PLOCK
 ..D PARSE(LOCK,.PARTS) ;PARTS(0)=count of subscripts in LOCK
 ..F  S TEMPLATE=$O(^XLM(8993,"AC",VAR,+TEMPLATE)) Q:'TEMPLATE  D  Q:MATCH
 ...Q:'$P($G(^XLM(8993,TEMPLATE,1)),"^",3)
 ...S PCOUNT=$P($G(^XLM(8993,TEMPLATE,2,0)),"^",4) ;PCOUNT=count of subscripts in TEMPLATE
 ...Q:PCOUNT'<PARTS(0)
 ...S PLOCK=$NA(LOCK,PCOUNT)
 ...S:$$MATCH(PLOCK,TEMPLATE,.FILES,.VARS) MATCH=1
 Q +TEMPLATE
 ;
MATCH(LOCK,IEN,FILES,XULMVAR) ;
 ;Description:  This function compares a lock to entries in the lock
 ;and returns 1 if they match, 0 otherwise.
 ;Input:
 ;   LOCK - an entry in the lock table
 ;   IEN - an entry# in the LOCK DICTIONARY
 ;Output:
 ;   function returns 1 if the lock matches the lock template, 0 otherwise
 ;   FILES (pass-by-reference) a list of files that can be referenced
 ;                             by LOCK. Subscripts are:
 ;           (<file #>)=<ien of the entry in FILE REFERENCES multip>
 ;   XULMVAR (pass-by-references) list of variables found within the lock
 ;                                template.  Subscripts are:
 ;           (<variable name>)=<value>
 ;           
 ;
 N NODE,ORDER,PARTS,PART,XULMBAD,XULMCODE,FILE,SUB,PARTIAL
 ;
 D PARSE(LOCK,.PARTS)
 Q:PARTS'=$P($$TEMPLATE^XULMU(IEN),"(") 0
 ;
 ;must have the same number of subscripts, OR, if partial matches allowed, possibly greater number of subscripts
 S PARTIAL=$P($G(^XLM(8993,IEN,1)),"^",3)
 I 'PARTIAL Q:PARTS(0)'=$P($G(^XLM(8993,IEN,2,0)),"^",4) 0
 I PARTIAL Q:PARTS(0)<$P($G(^XLM(8993,IEN,2,0)),"^",4) 0
 ;
 S (ORDER,SUB,XULMBAD)=0
 F ORDER=1:1:PARTS(0) S SUB=$O(^XLM(8993,IEN,2,"B",ORDER,0)) Q:'SUB  D  Q:XULMBAD
 .S NODE=$G(^XLM(8993,IEN,2,SUB,0))
 .I $P(NODE,"^",2)'=PARTS(ORDER) D
 ..N MUMPS
 ..I $P(NODE,"^",4)'="V" S XULMBAD=1 Q
 ..S XULMVAR($P(NODE,"^",2))=PARTS(ORDER)
 ..S MUMPS=$G(^XLM(8993,IEN,2,SUB,1))
 ..I $L(MUMPS) S XULMCODE($I(XULMCODE))=MUMPS
 ;
 Q:XULMBAD 'XULMBAD
 ;
 ;If there is variable check logic, execute it
 D
 .;define the application variables, but protect my own first
 .N I,IEN,LOCK,ORDER,PARTS,SUB,X,NODE,FILES,FILE,VAR,IDX,LOCKS
 .S VAR=""
 .F  S VAR=$O(XULMVAR(VAR)) Q:(VAR="")  N @VAR S @VAR=XULMVAR(VAR)
 .S XULMCODE=0
 .;
 .;execute the check logic - cached in XULMCODE
 .F  S XULMCODE=$O(XULMCODE(XULMCODE)) Q:'XULMCODE  D  Q:XULMBAD
 ..N Y
 ..N $ETRAP,$ESTACK S $ETRAP="G ERROR^XULMLD"
 ..X XULMCODE(XULMCODE)
 ..I $G(Y)'=1 S XULMBAD=1
 ;
 ;If this matches, get the file references
 I 'XULMBAD D
 .S FILE=0
 .F  S FILE=$O(^XLM(8993,IEN,3,"B",FILE)) Q:'FILE  S FILES(FILE)=$O(^XLM(8993,IEN,3,"B",FILE,0))
 E  K XULMVAR
 ;
 ;
 Q 'XULMBAD
 ;
PARSE(LOCK,PARTS) ;
 ;Parse the lock into its partS
 ;Input:
 ;   LOCK - entry from the lock table
 ;Output:
 ;   PARTS (pass by reference) the LOCK components are in this array
 ;
 N I
 K PARTS
 S PARTS(0)=$QLENGTH(LOCK)
 S PARTS=$QSUBSCRIPT(LOCK,0)
 F I=1:1:PARTS(0) S PARTS(I)=$QSUBSCRIPT(LOCK,I)
 Q
 ;
 ;
GETREFS(IEN,FILES,XULMVAR) ;
 ;Get file referencs for a lock.
 ;Input:
 ;  IEN - entry in the LOCK DICTIONARY
 ;  FILES - list of files to get references for
 ;  XULMVAR - variables parsed out of a lock table entry
 ;Output:
 ;  FILES - for each file on the list, returns the references info
 ;      (<file #>,"IEN")=<DA>^<DA(1)^DA(2)^etc.
 ;      (file #>,<1,2,3,etc.>)=<file identifier element>
 ;
 ;
 N XULMCODE,ID,FILE
 S FILE=0
 F  S FILE=$O(FILES(FILE)) Q:'FILE  S XULMCODE=$G(^XLM(8993,IEN,3,FILES(FILE),1)) D
 .D
 ..N FILE,IEN,FILES
 ..N $ETRAP,$ESTACK S $ETRAP="G ERROR^XULMLD"
 ..;we have the computable code, now set the variables
 ..S XULMVAR=""
 ..F  S XULMVAR=$O(XULMVAR(XULMVAR)) Q:(XULMVAR="")  N @XULMVAR S @XULMVAR=XULMVAR(XULMVAR)
 ..;
 ..;now XECUTE it! It will return ID()
 ..X XULMCODE
 .M FILES(FILE)=ID
 Q
 ;
ERROR ;
 S $ETRAP="Q:$QUIT """" Q"
 ;quit back to the Taskman error trap on these errors
 I ($ECODE["TOOMANYFILES")!($ECODE["EDITED") D  Q:$QUIT "" Q
 .D UNWIND^%ZTER
 ;can log error and continue processing
 N XUPARMS,LOGIN,PARMS
 D ^%ZTER
 S $ECODE=""
 Q:$QUIT "" Q
 ;
 ;
 ;
 ;
 ;
 ;
 ;
 ;
