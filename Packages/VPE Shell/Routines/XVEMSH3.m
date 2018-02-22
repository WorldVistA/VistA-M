XVEMSH3 ;DJB/VSHL**QWIK COMMANDS,USER QWIKS [3/6/95 7:27am];2017-08-15  5:00 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
QWIK ;;;
 ;;; Q W I K   C O M M A N D S
 ;;;
 ;;; The VShell allows the use of QWIK commands to greatly reduce the number
 ;;; of keystrokes required to accomplish your tasks. QWIK commands are words
 ;;; from 1 to 8 characters long, that, when invoked, will execute one line of
 ;;; Mumps code. There are two types of QWIK commands: System QWIKs & User QWIKs.
 ;;; System QWIKs come with the VShell and can not be altered. User QWIKs are
 ;;; created by you.
 ;;;
 ;;; To run a QWIK command, you type one dot and the command for a User QWIK, and
 ;;; two dots and the command for a System QWIK. If you created a User QWIK called
 ;;; 'E' to invoke your routine editor, you would type '.E' to run the QWIK. To
 ;;; run System QWIK VGL, the VGlobal Lister, you would type '..VGL', with two
 ;;; dots, since it's a System QWIK.
 ;;;
 ;;; The question you may have is "When should I create a User QWIK?". I can only
 ;;; tell you when I create a QWIK - If I type something over 3 times, I make a
 ;;; User QWIK to do it. For example, I have my own routine that I use to monitor
 ;;; the error log throughout the day. The routine is ^AAH2EVAX. So, I can type
 ;;; D ^AAH2EVAX all day long or make a User QWIK called 'ER' and type '.ER'. The
 ;;; QWIK command 'ER' requires only 1/3 of the keystrokes.
 ;;;
 ;;; Making a User QWIK command is very easy and you will learn more about that
 ;;; in the 'User QWIKS' help text.
 ;;;
 ;;; You can use the F1 key to view all QWIK commands that are available to
 ;;; you:
 ;;;       <F1>1...List User QWIKs and descriptions
 ;;;       <F1>2...List User QWIKs and their code
 ;;;       <F1>3...List System QWIKs and descriptions
 ;;;       <F1>4...List System QWIKs and their code
 ;;;
 ;;; NOTE: On a VT-100 keyboard substitute the PF1 key.
 ;;;
 ;;; Typing . or .. will bulk display User or System QWIKs. Typing . or .. and
 ;;; the first few characters will list QWIKs starting with those characters
 ;;; and allow a selection.
 ;;;***
USER ;;;
 ;;; U S E R   Q W I K S
 ;;;
 ;;; User QWIKs are your ticket to doing your work in half the keystrokes.
 ;;; Anything you do in programmer's mode can be done with a User QWIK. A User
 ;;; QWIK is a word, from 1 to 8 characters long, that will execute a line of
 ;;; Mumps code. To invoke a User QWIK, type one dot and the name.
 ;;;
 ;;; Let's assume that on your Mumps system you switch UCIs by entering: DO ^%ZUCI.
 ;;; Let's make a User QWIK command to do the same thing. To Add/Edit a QWIK, hit
 ;;; the <TAB> key. You will be prompted for the following:
 ;;;          Prompt         Your Answer
 ;;;      --------------  -----------------
 ;;;      NAME            UCI
 ;;;      CODE            D ^%ZUCI
 ;;;      DESCRIPTION     Switch UCIs
 ;;;      PARAM NOTES
 ;;;      BOX             1
 ;;; We've named the QWIK 'UCI'. The code we want it to execute is: 'DO ^%ZUCI'.
 ;;; The description is 'Switch UCIs' and we've stored it in Box '1'. For more
 ;;; information about PARAM NOTES and BOX, see help text for PARAMETER PASSING
 ;;; and BOXES.
 ;;;
 ;;; You are now done. Back at the '>>' prompt, you can now type '.UCI' whenever
 ;;; you want to switch UCIs. To see your new QWIK, hit <F1>1 or <F1>2 (List
 ;;; User QWIKs). Making a QWIK command is just that easy.
 ;;;
 ;;; You can type <F1>4 to list System QWIKs and their code. This may give you
 ;;; some ideas for making more sophisticated User QWIKs.
 ;;;***
