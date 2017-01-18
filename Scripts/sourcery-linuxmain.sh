#!/bin/bash
sourcery Tests Templates/LinuxMain.swift.stencil Tests/LinuxMain.swift --args "testimports=import TestHarnessTests
import TapsTests"
