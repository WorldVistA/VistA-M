ZJFOO ;ISF/RWF - GTM Routine to JOB an arbitrary entry point ;5/9/2002
 ;;8.0;KERNEL;**275**;Jul 10, 1995
 ;To run under VMS,
 ;  mumps ZJFOO.M
 ;  link ZJFOO.OBJ
 ;  In a com file
 ;  $ forfoo="$" + f$parse("user$:[gtmmgr.r]ZJFOO.exe")
 ;  $ forfoo "argument"
 ;To run under Linux
 ;  mumps ZJFOO.m
 ;  chmod u+x,g+x ZJFOO.o
 ;  In shell script
 ;  $gtm_dist/mumps -run ZJFOO "argument"
 ;
 ;Set the interupt
 S $ETRAP="D ^%ZTER HALT",$ZINTERRUPT="I $$JOBEXAM^ZU($ZPOSITION)"
 I $L($ZCMDLINE) J @$ZCMDLINE Q
 Q
