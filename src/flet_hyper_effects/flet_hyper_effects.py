from enum import Enum
from typing import Any, Optional
from typing import Any, List, Optional, Sequence, Union
from flet.core.constrained_control import ConstrainedControl
from flet.core.control import OptionalNumber

class HyperEffectsRoll(ConstrainedControl):
    """
    HyperEffectsRoll Control for animated rolling text.
    """

    def __init__(
        self,
        #
        # Control
        #
        size: OptionalNumber = None,
        opacity: OptionalNumber = None,
        tooltip: Optional[str] = None,
        visible: Optional[bool] = None,
        data: Any = None,
        #
        # ConstrainedControl
        #
        left: OptionalNumber = None,
        top: OptionalNumber = None,
        right: OptionalNumber = None,
        bottom: OptionalNumber = None,
        #
        # HyperEffectsRoll specific
        #
        words: Optional[list[str]] = ["Aboba","Lol","Lmao","Lulz"],
        loop_animation: Optional[bool] = True,
        value: Optional[str] = None,
    ):
        ConstrainedControl.__init__(
            self,
            tooltip=tooltip,
            opacity=opacity,
            visible=visible,
            data=data,
            left=left,
            top=top,
            right=right,
            bottom=bottom,
        )

        self.words = words
        self.size = size
        self.loop_animation = loop_animation
        self.value = value

    def _get_control_name(self):
        return "flet_hyper_effects_roll"

    # words
    @property
    def words(self):
        """
        A list of words to display in the rolling animation.
        """
        return self._get_attr("words")

    @words.setter
    def words(self, value: Optional[Sequence[str]]):
        self._set_attr_json("words", list(value))
    
    # size
    @property
    def size(self) -> OptionalNumber:
        return self._get_attr("size", data_type="float")

    @size.setter
    def size(self, value: OptionalNumber):
        self._set_attr("size", value)
        
    # loop_animation
    @property
    def loop_animation(self) -> Optional[bool]:
        return self._get_attr("loopAnimation", data_type="bool", def_value=True)

    @loop_animation.setter
    def loop_animation(self, value: Optional[bool]):
        self._set_attr("loopAnimation", value)
        
    # value
    @property
    def value(self) -> Optional[str]:
        return self._get_attr("value")

    @value.setter
    def value(self, value: Optional[str]):
        self._set_attr("value", value)
