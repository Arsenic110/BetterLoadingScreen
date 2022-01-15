// Pls be gentle this is my first mod, I know it's messy
// If there's better or more efficient ways of doing things please let me know :)

//No worries, Ill just rip it apart and sew it back together :3


using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Reflection;
using System.IO;
using UnhollowerRuntimeLib;
using MelonLoader;
using UnityEngine;
using Object = UnityEngine.Object;
using VRC;
using VRC.Core;


//Gutted by Arsen, original code all done by Grummus, AAMBIENTT, and thetrueyoshifan
[assembly: MelonInfo(typeof(NoMenuMusic.NoMenuMusicMod), "NoMenuMusic", "v0.1", "Arsen")]
[assembly: MelonGame("VRChat", "VRChat")]
[assembly: MelonOptionalDependencies("UIExpansionKit")]

namespace NoMenuMusic
{
	public class NoMenuMusicMod : MelonMod
	{

		// start of app
		public override void OnApplicationStart()
		{
			if (typeof(MelonMod).GetMethod("VRChat_OnUiManagerInit") == null)
				MelonCoroutines.Start(GetAssembly());
		}

		//return the assembly? I assume these are melonloader stuffs
		private IEnumerator GetAssembly()
		{
			Assembly assemblyCSharp = null;
			while (true)
			{
				assemblyCSharp = AppDomain.CurrentDomain.GetAssemblies().FirstOrDefault(assembly => assembly.GetName().Name == "Assembly-CSharp");
				if (assemblyCSharp == null)
					yield return null;
				else
					break;
			}
			MelonCoroutines.Start(WaitForUiManagerInit(assemblyCSharp));
		}

		//wait for UI manager
		private IEnumerator WaitForUiManagerInit(Assembly assemblyCSharp)
		{
			Type vrcUiManager = assemblyCSharp.GetType("VRCUiManager");
			PropertyInfo uiManagerSingleton = vrcUiManager.GetProperties().First(pi => pi.PropertyType == vrcUiManager);

			while (uiManagerSingleton.GetValue(null) == null)
				yield return null;

			GameObject.Find("/UserInterface/LoadingBackground_TealGradient_Music/LoadingSound").active = false;
			GameObject.Find("/UserInterface/MenuContent/Popups/LoadingPopup/LoadingSound").active = false;
		}
	}
}
