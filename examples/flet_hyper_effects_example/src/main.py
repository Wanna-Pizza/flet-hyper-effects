import time
import flet as ft

from flet_hyper_effects import FletHyperEffects,HyperEffectsRoll


def main(page: ft.Page):
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER
    hyper_obj = HyperEffectsRoll(value="Aboba", size=56, loop_animation=True)
    def change(e):
        hyper_obj.value = "Hell 123"
        hyper_obj.update()
    
    page.add(
        ft.Row([
            ft.ElevatedButton("Change text", on_click=change),
            ft.Text("Its", size=56),
            hyper_obj,
            ft.Text(" for Flet", size=56),
        
        ],alignment=ft.MainAxisAlignment.CENTER)
    )


ft.app(main)
