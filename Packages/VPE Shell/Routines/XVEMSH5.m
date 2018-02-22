XVEMSH5 ;DJB/VSHL**BOXES [07/14/94];2017-08-15  5:00 PM
 ;;14.1;VICTORY PROG ENVIRONMENT;;Aug 16, 2017
 ; Original Code authored by David J. Bolduc 1985-2005
 ;
BOXES ;;;
 ;;; B O X E S
 ;;;
 ;;; To help you organize the User QWIK commands you develop, the VShell allows you
 ;;; to store them in boxes. A box can be any whole number.
 ;;;
 ;;; Let's look at the UCI QWIK which we set up earlier. We had you assign it to
 ;;; box 1. You can display the QWIKs stored in box 1 by typing one dot and the
 ;;; box number. Type '.1' and you will see your UCI QWIK along with any other
 ;;; QWIKs that have been assigned to box 1.
 ;;;
 ;;; If you recall, you may display your User QWIKs by hitting <PF1> or <PF2>. You
 ;;; will find however, as you develop more and more User QWIKs, it becomes easier
 ;;; and clearer if you group them into boxes and display the boxes.
 ;;;
 ;;; System QWIKs also use boxes. To display the System QWIKs assigned to a box,
 ;;; type two dots and the box number. For example: '..1' will display all System
 ;;; QWIKs assigned to box 1. The System QWIKs have been grouped as follows:
 ;;;
 ;;;     Box 1..... All QWIK related System QWIKs
 ;;;     Box 2..... All VShell related System QWIKs
 ;;;     Box 3..... Programmers' Tools
 ;;;     Box 4..... Fileman/VA Kernel related System QWIKs
 ;;;     Box 5..... Vendor Generic Utilities
 ;;;
 ;;; Typing one or two dots and the box number will display QWIKs and their
 ;;; descriptions. If you wish to see the code they will execute, type a letter
 ;;; 'C' after the box number. So, '.1C' will display User QWIKs assigned to box 1
 ;;; and the code those QWIKs will execute.
 ;;;***
VENDOR ;;;
 ;;; V E N D O R    S P E C I F I C   C O N F I G U R A T I O N S
 ;;;
 ;;; The VShell will allow you to set up an environment that will work the same
 ;;; regardless of which Mumps system you are running.
 ;;;
 ;;; Using the QV System QWIK, you can make User QWIKs that execute different code
 ;;; depending on your Mumps implementation. To illustrate, let's take the QWIK
 ;;; called UCI you set up earlier, and make it so this QWIK will work in both
 ;;; Micronetics and DataTree Mumps.
 ;;;
 ;;; In Micronetics Mumps you switch UCIs with 'DO ^%LOGON'. In DataTree you use
 ;;; 'd ^%nspace'. We've already set up a UCI QWIK. Now type '..QV'. You will be
 ;;; prompted for a QWIK name. Enter 'UCI'. Next, the VShell will display a list
 ;;; of vendors and you will be asked to select one. Then it will ask for the
 ;;; vendor specific code you want this QWIK to execute. You first select
 ;;; Micronetics and enter 'DO ^%LOGON'. Next, you select DataTree and enter
 ;;; 'd ^%nspace'. That's all there is to it.
 ;;;
 ;;; When you first enter the VShell, it identifies what Mumps vendor you are
 ;;; using. Whenever it executes a User QWIK, it first checks to see if there
 ;;; is a vendor specific version. If there is, it executes it. If there isn't,
 ;;; it executes the non-vendor specific version.
 ;;;
 ;;; There are a number of Vendor Generic System QWIKs located in box 5. These
 ;;; QWIKs have been set up using the principles described above. They will work
 ;;; the same for DSM, VAX DSM, DataTree, and Micronetics Mumps.
 ;;;***
