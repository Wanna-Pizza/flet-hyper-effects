import time
import flet as ft

from flet_hyper_effects import HyperEffectsRoll,HyperEffectsType
from flet_hyper_effects import GoogleFont
import asyncio

def main(page: ft.Page):
    page.vertical_alignment = ft.MainAxisAlignment.CENTER
    page.horizontal_alignment = ft.CrossAxisAlignment.CENTER

    async def update_text():
        string_new = "Welcome to App."
        string_splitet = string_new.split(" ")
        for index,i in enumerate(row.controls):
            i.value = string_splitet[index]
            i.update()
            await asyncio.sleep(0.5)
    async def update_text_1():
        string_new = "Wait until finish."
        string_splitet = string_new.split(" ")
        for index,i in enumerate(row.controls):
            i.value = string_splitet[index]
            i.update()
            await asyncio.sleep(0.7)
    
    string = "Hello my Friend."
    string_splitet = string.split(" ")

    row = ft.Row([],alignment=ft.MainAxisAlignment.CENTER)
    for i in string_splitet:
        row.controls.append(
            HyperEffectsRoll(
                value=i, 
                size=56,
                effect_type=HyperEffectsType.ROLL)
        )
    
    def run_animation(e):
        page.run_task(update_text)
        time.sleep(4)
        page.run_task(update_text_1)
    
    def button_text():
        button = ft.Container(
            height=50,
            content=ft.Text("Next"),
            bgcolor='white,0.1',
            alignment=ft.alignment.center,
            expand=True,
            border_radius=10,
            ink=True,
            on_click=run_animation
            
            )
        return button

    page.add(
        ft.Stack([
            ft.Column([row],horizontal_alignment=ft.CrossAxisAlignment.CENTER,alignment=ft.MainAxisAlignment.CENTER),
            ft.Column([
                ft.Row([button_text()],alignment=ft.MainAxisAlignment.CENTER)
            ],alignment=ft.MainAxisAlignment.END,horizontal_alignment=ft.CrossAxisAlignment.END),
            ],expand=True)
        
        )


ft.app(main)
