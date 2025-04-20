# Introduction

FletHyperEffects for Flet.

## Examples

```
import flet as ft

from flet_hyper_effects import FletHyperEffects


def main(page: ft.Page):
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER

    page.add(

                ft.Container(height=150, width=300, alignment = ft.alignment.center, bgcolor=ft.Colors.PURPLE_200, content=FletHyperEffects(
                    tooltip="My new FletHyperEffects Control tooltip",
                    value = "My new FletHyperEffects Flet Control", 
                ),),

    )


ft.app(main)
```

## Classes

[FletHyperEffects](FletHyperEffects.md)


