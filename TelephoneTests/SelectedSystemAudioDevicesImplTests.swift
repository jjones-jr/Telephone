//
//  SelectedSystemAudioDevicesImplTests.swift
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

import XCTest

class SelectedSystemAudioDevicesImplTests: XCTestCase {

    var deviceFactory: SystemAudioDeviceTestFactory!
    var systemDevices: SystemAudioDevices!
    var userDefaultsStub: UserDefaultsStub!
    var selectedDevices: SelectedSystemAudioDevicesImpl!

    override func setUp() {
        super.setUp()
        deviceFactory = SystemAudioDeviceTestFactory()
        systemDevices = SystemAudioDevicesImpl(devices: deviceFactory.allDevices)
        userDefaultsStub = UserDefaultsStub()
        selectedDevices = SelectedSystemAudioDevicesImpl(systemAudioDevices: systemDevices, userDefaults: userDefaultsStub)
    }

    // MARK: - Sound input

    func testSelectsAudioDeviceWithNameFromUserDefaultsAsSoundInput() {
        let someDevice = deviceFactory.someInputDevice
        userDefaultsStub[kSoundInput] = someDevice.name

        XCTAssertEqual(selectedDevices.soundInput, someDevice)
    }

    func testSelectsBuiltInAudioInputDeviceAsSoundInputIfThereIsNoSoundInputInUserDefaults() {
        XCTAssertEqual(selectedDevices.soundInput, systemDevices.builtInInput)
    }

    func testSelectsBuiltInAudioInputDeviceAsSoundInputIfSoundInputFromUserDefaultsCanNotBeFoundInSystemDevices() {
        userDefaultsStub[kSoundInput] = kNonexistentDeviceName

        XCTAssertEqual(selectedDevices.soundInput, systemDevices.builtInInput)
    }

    func testSelectsBuiltInAudioInputDeviceAsSoundInputIfAudioDeviceMatchedByNameFromUserDefaultsDoesNotHaveInputChannels() {
        userDefaultsStub[kSoundInput] = deviceFactory.outputOnlyDevice.name

        XCTAssertEqual(selectedDevices.soundInput, systemDevices.builtInInput)
    }

    // MARK: - Sound output

    func testSelectsAudioDeviceWithNameFromUserDefaultsAsSoundOutput() {
        let someDevice = deviceFactory.someOutputDevice
        userDefaultsStub[kSoundOutput] = someDevice.name

        XCTAssertEqual(selectedDevices.soundOutput, someDevice)
    }

    func testSelectsBuiltInAudioOutputDeviceAsSoundOutputIfThereIsNoSoundOutputInUserDefaults() {
        XCTAssertEqual(selectedDevices.soundOutput, systemDevices.builtInOutput)
    }

    func testSelectsBuiltInAudioOutputDeviceAsSoundOutputIfSoundOutputFromUserDefaultsCanNotBeFoundInSystemDevices() {
        userDefaultsStub[kSoundOutput] = kNonexistentDeviceName

        XCTAssertEqual(selectedDevices.soundOutput, systemDevices.builtInOutput)
    }

    func testSelectsBuiltInAudioOutputDeviceAsSoundOutputIfAudioDeviceMatchedByNameFromUserDefaultsDoesNotHaveOutputChannels() {
        userDefaultsStub[kSoundOutput] = deviceFactory.inputOnlyDevice.name

        XCTAssertEqual(selectedDevices.soundOutput, systemDevices.builtInOutput)
    }

    // MARK: - Ringtone output

    func testSelectsAudioDeviceWithNameFromUserDefaultsAsRingtoneOutput() {
        let someDevice = deviceFactory.someOutputDevice
        userDefaultsStub[kRingtoneOutput] = someDevice.name

        XCTAssertEqual(selectedDevices.ringtoneOutput, someDevice)
    }

    func testSelectsBuiltInAudioOutputDeviceAsRingtoneOutputIfThereIsNoRingtoneOutputInUserDefaults() {
        XCTAssertEqual(selectedDevices.ringtoneOutput, systemDevices.builtInOutput)
    }

    func testSelectsBuiltInAudioOutputDeviceAsRingtoneOutputIfRingtoneOutputFromUserDefaultsCanNotBeFoundInSystemDevices() {
        userDefaultsStub[kRingtoneOutput] = kNonexistentDeviceName

        XCTAssertEqual(selectedDevices.ringtoneOutput, systemDevices.builtInOutput)
    }

    func testSelectsBuiltInAudioOutputDeviceAsRingtoneOutputIfAudioDeviceMatchedByNameFromUserDefaultsDoesNotHaveOutputChannels() {
        userDefaultsStub[kRingtoneOutput] = deviceFactory.inputOnlyDevice.name

        XCTAssertEqual(selectedDevices.ringtoneOutput, systemDevices.builtInOutput)
    }
}

private let kNonexistentDeviceName = "Nonexistent"
