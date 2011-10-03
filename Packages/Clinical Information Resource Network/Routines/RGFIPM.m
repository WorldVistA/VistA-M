RGFIPM ;ALB/CJM-PROCESS FACILITY INTEGRATION MESSAGE ;08/27/99
 ;;1.0;CLINICAL INFO RESOURCE NETWORK;**5**;30 Apr 99
 ;
XCHANGE(DFN,LEGSN,PRIMSN,ERROR) ;
 ;Description:  If the CMOR is the legacy site it changes to the
 ;primary site. If the legacy system is on the treating facility list
 ;it is removed.  If the primary system is not on the treating facility
 ;list it is added.The subscription for the legacy system is terminated.
 ;If the primary system is not on the subscriber list it is added.
 ;
 ;Input:
 ;  DFN - ien of patient (required)
 ;  LEGSN- station # of the legacy site (required)-
 ;  PRIMSN - station # of the primary site (required)
 ;Output:
 ;  Function Value - 0 if any error condition encountered, 1 otherwise
 ;  ERROR() - (optional,pass by reference) - an array of error messages
 ;
 ;Variables:
 ;  PRIMIEN - ien of the primary site in the Institution file
 ;  PRIMLINK - name of logical link for primary site
 ;  FOUNDERR - flag set to 1 if an error is found
 ;  MPIDATA() - array containing MPI data for this patient
 ;
 N PRIMIEN,PRIMLINK,FOUNDERR,MPIDATA,RETURN,LEGIEN
 ;
 D
 .S FOUNDERR=0
 .I DFN,LEGSN,PRIMSN
 .E  D ADDERROR("INPUT PARAMETER MISSING, TAG=XCHANGE,RTN=RGFIPM",6) Q
 .;
 .S PRIMIEN=$$LKUP^XUAF4(PRIMSN)
 .I 'PRIMIEN D ADDERROR("INSTITUTION LOOKUP FAILED, STATION# = "_PRIMSN,229) Q
 .S LEGIEN=$$LKUP^XUAF4(LEGSN)
 .I 'LEGIEN D ADDERROR("INSTITUTION LOOKUP FAILED, STATION# = "_LEGSN,229)
 .;
 .D GETALL^RGFIU(DFN,.MPIDATA)
 .;
 .;if the legacy site is the CMOR change it to the primary site
 .I MPIDATA("CMOR")=LEGSN,($$CHANGE^MPIF001(DFN,PRIMIEN)'=1) D ADDERROR("ERROR CHANGING CMOR TO "_PRIMSN,6)
 .;
 .;if the legacy system is on the TF list, remove it
 .I $D(MPIDATA("TF",LEGSN)) S RETURN=$$DELETETF^VAFCTFU(MPIDATA("ICN"),MPIDATA("TF",LEGSN,"INSTIEN")) I +RETURN D ADDERROR("FAILURE TO DELETE TREATING FACILITY = "_LEGSN,6)
 .;
 .;if the primary site is not on the TF list, then add it OR
 .;its on the Tf list but with an earlier date than the legacy and legacy has an event reason OR legacy has an event reason and primary doesn't, change it
 .I ('$D(MPIDATA("TF",PRIMSN)))!($G(MPIDATA("TF",PRIMSN,"LASTDATE"))<$G(MPIDATA("TF",LEGSN,"LASTDATE"))&$G(MPIDATA("TF",LEGSN,"EVENT")))!($G(MPIDATA("TF",LEGSN,"EVENT"))&('$G(MPIDATA("TF",PRIMSN,"EVENT")))) D 
 ..;should not be necessar to delete old TF entry for primary before calling FILE^VACTFU
 ..;I $D(MPIDATA("TF",PRIMSN)) S RETURN=$$DELETETF^VAFCTFU(MPIDATA("ICN"),MPIDATA("TF",PRIMSN,"INSTIEN"))
 ..;
 ..D FILE^VAFCTFU(DFN,PRIMIEN_"^"_$G(MPIDATA("TF",LEGSN,"LASTDATE"))_"^"_$G(MPIDATA("TF",LEGSN,"EVENT")),1)
 .;
 .Q:'MPIDATA("SUB")
 .;Terminate the subscription of legacy site
 .I LEGIEN,LEGIEN'=+$$SITE^VASITE D UPD^HLSUB(MPIDATA("SUB"),$$GETLINK^RGFIU(LEGIEN),,,$$NOW^XLFDT)
 .;
 .;if the primary site is not on the subscription list then add it - unless this site is the primary site!
 .D
 ..Q:(($P($$SITE^VASITE(),"^",3))=PRIMSN)
 ..;Add primary site as a subscriber
 ..N ERR
 ..;Get the logical link for the primary site
 ..S PRIMLINK=$$GETLINK^RGFIU(PRIMIEN)
 ..I PRIMLINK="" D ADDERROR("FAILURE TO ADD SUBSCRIPTION FOR STATION# = "_PRIMSN,224) Q
 ..D UPD^HLSUB(MPIDATA("SUB"),PRIMLINK,0,,"@",,.ERR)
 ..I $O(ERR(0)) D ADDERROR("FAILURE TO ADD SUBSCRIPTION FOR STATION# = "_PRIMSN,6)
 Q $S(FOUNDERR:0,1:1)
 ;
ADDERROR(MSG,CODE) ;
 ;Description:  Puts the error message on a list.  If an exception type code is passed the exception handler will be called.
 ;
 ;Input:
 ;  MSG - message text
 ;  CODE  - a CIRN exception type (optional)
 ;  ERROR() - this is the array where errors are being tracked
 ;  DFN - the patient DFN should be defined
 ;Output:
 ;  ERROR() array has the addtional error entered
 ;  FOUNDERR is set to 1, is a flag indicating that an error was encountered
 ;
 N NEXT
 S FOUNDERR=1
 S NEXT=($O(ERROR(-1))+1)
 S ERROR(NEXT)=MSG
 S ERROR(NEXT,"CODE")=$G(CODE)
 I $G(CODE),$G(DFN) D EXC^RGFIU(CODE,"FACILITY INTEGRATION ERROR: "_$P($$ERROR^RGFIPM1(MSG,CODE,$$ICN^RGFIU(DFN)),"^",2),DFN)
 Q
