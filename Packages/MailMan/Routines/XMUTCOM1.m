XMUTCOM1 ;(WASH ISC)/CAP-XMUSRCNT.COM Count users (shareware) ;04/17/2002  12:10
 ;;8.0;MailMan;;Jun 28, 2002
ZZZ ;$!USERS.COM
 ;;$!            milt's special
 ;;$ set noon
 ;;$ ANS="N"
 ;;$ pur/nolog leeuser.log
 ;;$! del/nolog u1*.tmp.*,u2*.tmp.*
 ;;$! say " Scanning VMS interactive users..............."
 ;;$ SH USER/INTER/full/OUTPUT=U1.TMP
 ;;$! say " Scanning VMS batch users (ZSLOT) ............"
 ;;$ SH USER/BATCH/full/OUTPUT=U2.TMP
 ;;$ search/output=u11.tmp u1.tmp forum
 ;;$ search/output=u22.tmp u2.tmp bf
 ;;$ search/output=u222.tmp u22.tmp op_/match=nor
 ;;$ APPEND U222.TMP U11.TMP
 ;;$ cnt=0
 ;;$ bfcnt=0
 ;;$ open/read a U11.TMP
 ;;$READ_LOOP:    !read USERS.tmp and start extracting what we need
 ;;$ read/end=eof/error=error a line
 ;;$ if f$extract(0,1,ans) .nes. ""  then goto next_step
 ;;$! say line
 ;;$ next_step:
 ;;$ if f$extract(1,2,line) .eqs. "BF" then bfcnt=bfcnt+1
 ;;$ cnt=cnt+1
 ;;$ goto read_loop
 ;;$ next_one:
 ;;$EOF:   !end of file
 ;;$ close a
 ;;$ set ver
 ;;$ open/append a XMUSRCNT.sav
 ;;$ vmscnt=cnt-bfcnt
 ;;$ time_stamp=f$time()
 ;;$ scnt=f$string(cnt)
 ;;$ svmscnt=f$string(vmscnt)
 ;;$ sbfcnt=f$string(bfcnt)
 ;;$ usercnt="''scnt',''sbfcnt',''svmscnt',''time_stamp'"
 ;;$ write a "*****************************************************"
 ;;$ write a time_stamp
 ;;$ write a " VMS logins = "'VMSCNT'"."
 ;;$ write a " VMS Batch jobs running = "'bfcnt'"."
 ;;$ write a " TOTAL Interactive and Batch users = "'CNT'"."
 ;;$ write a ''usercnt'
 ;;$ close a
 ;;$ purge/nolog leeuser.sav
 ;;$ delete/nolog U1*.TMP.*,U2*.TMP.*
 ;;$ dsm/envir=mgrmail/data="''usercnt'" ENUSER^XMUT5Q
 ;;$! submit/que=forum7_batch XMUSRCNT.COM
 ;;$ set nover
 ;;$ exit
 ;;$ERROR:
 ;;$ say "Error has occurred during processing."
 ;;$ SAY " "
 ;;$! goto eof
 ;;$exit
