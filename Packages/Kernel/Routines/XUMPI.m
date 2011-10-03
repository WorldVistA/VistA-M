XUMPI ;ALB/CMC-TRIGGER X-REF ON NEW PERSON FIELDS FOR MPI ;8/5/2010
 ;;8.0;KERNEL;**551**;Jul 10, 1995;Build 2
 ;
XREF(DA) ;TRIGGER TO SET THE REQUIRES TRANSMISSION FIELD if the NEW PERSON Enumeration process has started
 ;8989.3,900    New Person Enumeration Started MPI;1 DATE
 N IEN,FDA,XUERR
 S IEN=$O(^XTV(8989.3,0))
 Q:$P($G(^XTV(8989.3,IEN,"MPI")),"^",1)=""
 ;enumeration has started so set the Requires Transmission field in NEW PERSON for this Record
 S FDA(200,DA_",",902)="Y"
 D FILE^DIE("E","FDA","XUERR")
 ;what to do if can't set the field???
 Q 
