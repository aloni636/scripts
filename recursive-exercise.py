class Context:
    def _init_(self, max_level=5) -> None:
        self.max_level = max_level
        self.current_level = max_level
        self.current_char = 0
        self.stdout: str = ''

    def recurse(self):
        # Break condition
        if -(self.current_level) > self.max_level:
            pass
        # Middle control
        elif self.current_level == 0:
            self.current_level = -2
            self.current_char = 0
            self.recurse()
        # Characters control
        else:
            if self.current_char+1 == self.max_level+abs(self.current_level):
                self.current_level -= 1
                self.current_char = 0
                self.stdout += '\n'
                self.recurse()
            else:
                char = ''
                max_current_diff = self.max_level-abs(self.current_level)

                if self.current_char < max_current_diff:
                    char = ' '
                # compensate for space characters on odd levels
                elif (self.current_char+max_current_diff) % 2 == 0:
                    char = '!'
                else:
                    char = '.'
                self.current_char += 1
                self.stdout += char
                self.recurse()


for i in range(1, 5+1, 1):
    print(f'paremeter: {i}\n============')
    c = Context(i)
    c.recurse()
    print(c.stdout)
