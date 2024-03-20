package com.example.shortcuts

import android.content.Context
import android.content.Intent
import android.content.pm.ShortcutInfo
import android.content.pm.ShortcutManager
import android.graphics.drawable.Icon
import android.os.Build
import androidx.annotation.RequiresApi
import androidx.core.content.ContextCompat.getSystemService

@RequiresApi(Build.VERSION_CODES.N_MR1)
object Shortcuts {

    fun setUp(context: Context, name: String) {
        val shortcutManager = getSystemService(context, ShortcutManager::class.java)

        val intent =
            Intent(Intent.ACTION_VIEW, null, context, MainActivity::class.java)
        intent.putExtra("screenToOpen", name)

        val shortcut = ShortcutInfo.Builder(context, name).setShortLabel(name)
            .setLongLabel("Open other screen")
            .setIcon(Icon.createWithResource(context, R.drawable.page))

            .setIntent(intent)
            .build()

        shortcutManager!!.dynamicShortcuts = listOf(shortcut)
    }
}