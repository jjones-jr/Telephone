//
//  CallController.h
//  Telephone
//
//  Copyright (c) 2008-2015 Alexei Kuznetsov. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//  1. Redistributions of source code must retain the above copyright notice,
//     this list of conditions and the following disclaimer.
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution.
//  3. Neither the name of the copyright holder nor the names of contributors
//     may be used to endorse or promote products derived from this software
//     without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
//  THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
//  PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE THE COPYRIGHT HOLDER
//  OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
//  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
//  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
//  OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
//  WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
//  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
//  ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//

#import <Cocoa/Cocoa.h>

#import "AKSIPCall.h"
#import "XSWindowController.h"

#import "CallControllerDelegate.h"


@class AccountController, AKSIPCall, AKResponsiveProgressIndicator, AKSIPURI;
@class IncomingCallViewController, ActiveCallViewController;
@class EndedCallViewController, CallTransferController;

// A call controller.
@interface CallController : XSWindowController <AKSIPCallDelegate> {
  @protected
    ActiveCallViewController *_activeCallViewController;
    EndedCallViewController *_endedCallViewController;
}

@property(nonatomic, readonly, weak) id<CallControllerDelegate> delegate;

// The receiver's identifier.
@property(nonatomic, copy) NSString *identifier;

// Call controlled by the receiver.
@property(nonatomic, strong) AKSIPCall *call;

// Account controller the receiver belongs to.
@property(nonatomic, weak) AccountController *accountController;

// Call transfer controller.
@property(nonatomic, readonly) CallTransferController *callTransferController;


// Incoming call view controller.
@property(nonatomic, readonly) IncomingCallViewController *incomingCallViewController;

// Active call view controller.
@property(nonatomic, readonly, strong) ActiveCallViewController *activeCallViewController;

// Ended call view controller.
@property(nonatomic, readonly, strong) EndedCallViewController *endedCallViewController;


// Remote party dislpay name.
@property(nonatomic, copy) NSString *displayedName;

// Call status.
@property(nonatomic, copy) NSString *status;

// Remote party name from the Address Book.
@property(nonatomic, copy) NSString *nameFromAddressBook;

// Remote party label from the Address Book.
@property(nonatomic, copy) NSString *phoneLabelFromAddressBook;

// Call destination entered by a user.
@property(nonatomic, copy) NSString *enteredCallDestination;

// SIP URI for the redial.
@property(nonatomic, copy) AKSIPURI *redialURI;

// Timer to display intermediate call status. This status appears for the short period of time and then is being
// replaced with the current call status.
@property(nonatomic, strong) NSTimer *intermediateStatusTimer;

// Call start time.
@property(nonatomic, assign) NSTimeInterval callStartTime;

// A Boolean value indicating whether the receiver's call is on hold.
@property(nonatomic, assign, getter=isCallOnHold) BOOL callOnHold;

// A Boolean value indicating whether the receiver's call is active.
@property(nonatomic, assign, getter=isCallActive) BOOL callActive;

// A Boolean value indicating whether the receiver's call is unhandled.
@property(nonatomic, assign, getter=isCallUnhandled) BOOL callUnhandled;


- (instancetype)initWithWindowNibName:(NSString *)windowNibName accountController:(AccountController *)accountController delegate:(id<CallControllerDelegate>)delegate;

// Accepts an incoming call.
- (void)acceptCall;

// Hangs up a call.
- (void)hangUpCall;

// Redials a call.
- (void)redial;

// Toggles call hold.
- (void)toggleCallHold;

// Toggles microphone mute.
- (void)toggleMicrophoneMute;

// Sets intermediate call status. This status appears for the short period of time and then is being replaced with the
// current call status.
- (void)setIntermediateStatus:(NSString *)newIntermediateStatus;

// Method to be called when intermediate call status timer fires.
- (void)intermediateStatusTimerTick:(NSTimer *)theTimer;

- (void)showActiveCallView;
- (void)showEndedCallView;
- (void)showIncomingCallView;

@end
