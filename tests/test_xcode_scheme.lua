---
-- tests/test_xcode_scheme.lua
-- Automated test suite for Xcode scheme generation.
-- Copyright (c) 2011-2016 Jason Perkins and the Premake project
---


	local suite = test.declare("xcode4_scheme")
	local xcode = premake.modules.xcode
	local scheme = xcode.scheme

---------------------------------------------------------------------------
-- Setup/Teardown
---------------------------------------------------------------------------

	local wks, prj

	function suite.teardown()
		wks = nil
		prj = nil
	end

	function suite.setup()
		_ACTION = "xcode4"
		xcode.used_ids = { } -- reset the list of generated IDs

		wks = test.createWorkspace()
	end

	local function prepare()
		wks = premake.oven.bakeWorkspace(wks)
		xcode.prepareWorkspace(wks)
		prj = premake.workspace.getproject(wks, 1)
		local tr = xcode.buildprjtree(prj)
	end

---------------------------------------------------------------------------
-- Header
---------------------------------------------------------------------------

	function suite.scheme_header()
		prepare()
		scheme.Header(prj)
		test.capture [[
<?xml version="1.0" encoding="UTF-8"?>
<Scheme
	LastUpgradeVersion = "0500"
	version = "1.3">
		]]
	end

---------------------------------------------------------------------------
-- Footer
---------------------------------------------------------------------------

	function suite.scheme_footer()
		prepare()
		scheme.Footer(prj)
		test.capture [[
</Scheme>
		]]
	end

---------------------------------------------------------------------------
-- Build
---------------------------------------------------------------------------

	function suite.scheme_build()
		prepare()
		scheme.build(prj)
		test.capture [[
<BuildAction
	parallelizeBuildables = "YES"
	buildImplicitDependencies = "YES">
	<BuildActionEntries>
		<BuildActionEntry
			buildForTesting = "YES"
			buildForRunning = "YES"
			buildForProfiling = "YES"
			buildForArchiving = "YES"
			buildForAnalyzing = "YES">
			<BuildableReference
				BuildableIdentifier = "primary"
				BlueprintIdentifier = "[MyProject:target]"
				BuildableName = "MyProject"
				BlueprintName = "MyProject"
				ReferencedContainer = "container:MyProject.xcodeproj">
			</BuildableReference>
		</BuildActionEntry>
	</BuildActionEntries>
</BuildAction>
		]]
	end

---------------------------------------------------------------------------
-- Test
---------------------------------------------------------------------------

	function suite.scheme_test()
		prepare()
		scheme.test(prj)
		test.capture [[
<TestAction
	selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
	selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
	shouldUseLaunchSchemeArgsEnv = "YES"
	buildConfiguration = "Debug">
	<Testables>
	</Testables>
	<MacroExpansion>
		<BuildableReference
			BuildableIdentifier = "primary"
			BlueprintIdentifier = "[MyProject:target]"
			BuildableName = "MyProject"
			BlueprintName = "MyProject"
			ReferencedContainer = "container:MyProject.xcodeproj">
		</BuildableReference>
	</MacroExpansion>
</TestAction>
		]]
	end

---------------------------------------------------------------------------
-- Launch
---------------------------------------------------------------------------

	function suite.scheme_launch()
		prepare()
		scheme.launch(prj)
		test.capture [[
<LaunchAction
	selectedDebuggerIdentifier = "Xcode.DebuggerFoundation.Debugger.LLDB"
	selectedLauncherIdentifier = "Xcode.DebuggerFoundation.Launcher.LLDB"
	launchStyle = "0"
	useCustomWorkingDirectory = "NO"
	buildConfiguration = "Debug"
	ignoresPersistentStateOnLaunch = "NO"
	debugDocumentVersioning = "NO"
	allowLocationSimulation = "YES">
	<BuildableProductRunnable>
		<BuildableReference
			BuildableIdentifier = "primary"
			BlueprintIdentifier = "[MyProject:target]"
			BuildableName = "MyProject"
			BlueprintName = "MyProject"
			ReferencedContainer = "container:MyProject.xcodeproj">
		</BuildableReference>
	</BuildableProductRunnable>
	<AdditionalOptions>
	</AdditionalOptions>
</LaunchAction>
		]]
	end

---------------------------------------------------------------------------
-- Profile
---------------------------------------------------------------------------

	function suite.scheme_profile()
		prepare()
		scheme.profile(prj)
		test.capture [[
<ProfileAction
	shouldUseLaunchSchemeArgsEnv = "YES"
	savedToolIdentifier = ""
	useCustomWorkingDirectory = "NO"
	buildConfiguration = "Release"
	debugDocumentVersioning = "NO">
	<BuildableProductRunnable>
		<BuildableReference
			BuildableIdentifier = "primary"
			BlueprintIdentifier = "[MyProject:target]"
			BuildableName = "MyProject"
			BlueprintName = "MyProject"
			ReferencedContainer = "container:MyProject.xcodeproj">
		</BuildableReference>
	</BuildableProductRunnable>
</ProfileAction>
		]]
	end

---------------------------------------------------------------------------
-- Analyze
---------------------------------------------------------------------------

	function suite.scheme_analyze()
		prepare()
		scheme.analyze(prj)
		test.capture [[
<AnalyzeAction
	buildConfiguration = "Debug">
</AnalyzeAction>
		]]
	end

---------------------------------------------------------------------------
-- Archive
---------------------------------------------------------------------------

	function suite.scheme_archive()
		prepare()
		scheme.archive(prj)
		test.capture [[
<ArchiveAction
	buildConfiguration = "Release"
	revealArchiveInOrganizer = "YES">
</ArchiveAction>
		]]
	end

