<a id="readme-top"></a>


<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]



<!-- PROJECT LOGO -->
<br />
<div align="center">
  <h3 align="center">NextCV Temple</h3>

  <p align="center">
    The template class for a next generation resume/curriculum vitae.
    <br />
    <br />
    <a href="https://github.com/D-Naveenz/NextCV/issues/new?labels=bug&template=bug-report---.md">Report Bug</a>
    ·
    <a href="https://github.com/D-Naveenz/NextCV/issues/new?labels=enhancement&template=feature-request---.md">Request Feature</a>
  </p>
</div>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a>
      <ul>
        <li><a href="#requirements-and-compilation">Requirements and Compilation</a></li>
        <li><a href="#template-file">Template file</a></li>
        <li><a href="#clickable-info-fields">Clickable Info fields</a></li>/'
        <li><a href="#new-information-fields">New Information Fields</a></li>
        <li><a href="#configurable-colours">Configurable colours</a></li>
        <li><a href="#configurable-fonts">Configurable fonts</a></li>
        <li><a href="#configurable-icons">Configurable icons</a></li>
        <li><a href="#is-this-template-ats-friendly">Is this template ATS-friendly?</a></li>
      </ul>
    </li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## About The Project

NextCV is a modern and customizable LaTeX class for creating beautiful and professional resumes or CVs. This class is an upgraded version of the [AltaCV](https://github.com/liantze/AltaCV) (v1.7.1) originally written by LianTze Lim. The upgrades and improvements have been implemented by Naveen Dharmathunga.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Features
* Easy to customize and extend
* Supports both round and square photos
* Hyperlink support for email, phone, LinkedIn, GitHub, etc.
* Beautiful section and subsection formatting
* Skill rating with customizable markers
* Option to use different fonts and colors



### Built With

[![LaTeX][latex-shield]][latex-url]



## Getting Started

### Prerequisites

In **Windows**,
* [MikeTex](https://miktex.org/download)
* VS Code (preferable)
  * Latex Workshop extention
  * [Perl](https://strawberryperl.com/)



### Installation

* Download the repository:
  ```sh
  git clone https://github.com/D-Naveenz/NextCV
  ```
* Make a copy of these files into your project
  * `nextcv.cls`
  * `template.tex`
  * `Globe_High.png`

<p align="right">(<a href="#readme-top">back to top</a>)</p>



---

<!-- USAGE EXAMPLES -->
## Usage

### Requirements and Compilation

* Use `latexmk (xelatex)` *(or `xelatex`)*
* NextCV uses [`fontawesome6`](https://github.com/D-Naveenz/fontawsome6-latex).
* Use the `normalphoto` option to get normal (i.e. non-circular) photos.
* You can add multiple photos on the left or right: `\photoL{2cm}{logo1}` and `\photoR{2.5cm}{logo2,photo}`. (`\photo` will work like `\photoR`.) Separate your image filenames with commas _without_ spaces.
* Use the `ragged2e` option to activate hyphenations while keeping text left-justified; line endings will thus be less jagged and more aesthetically pleasing.
* The `withhyper` document class option will make the "personal info" fields into clickable hyperlinks (where it makes sense). See below for more details.
* Can now be compiled with XeLaTeX and LuaLaTeX!
  * Note that to compile with XeLaTeX, you should use a command line as follows, `xelatex -shell-escape -output-driver="xdvipdfmx -z 0" sample.tex`
* The samples here use the [Lato](http://www.latofonts.com/lato-free-fonts/) and [Exo 2](https://fonts.google.com/specimen/Exo+2). Feel free to use a different typeface package instead—often a different typeface will change the entire CV's feel.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Template file

Many users have overlooked the optional argument of `\cvsection` to insert the right sidebar contents, and often confused that the right sidebar doesn't automatically break across pages. This new layout uses the `paracol` package for typesetting the left and right columns that _can_ break across pages. It also makes changing the column widths easier:

```latex
%% Set the left/right column width ratio to 6:4.
\columnratio{0.6}

% Start a 2-column paracol. Both the left and right columns will automatically
% break across pages if things get too long.
\begin{paracol}{2}
\cvsection{Experience}
...
... END OF LEFT COLUMN CONTENTS ...

% Now switch to the right column.
\switchcolumn
\cvsection{Education}
...
...END OF RIGHT COLUMN CONTENTS ...
\end{paracol}
```
You can also use `\swithcolumn*` for "synchronising" the columns, as well as other commands from the `paracol` package. See the [`paracol` package documentation](http://texdoc.net/pkg/paracol) for further details.

**You do not need use the `fullwidth` environment nor use optional arguments with `\cvsection` with this new template.**

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Clickable Info fields

As of v1.3, the `withhyper` document class option will load the `hyperref` package, and make fields in the personal detail fields into clickable hyperlinks (where it makes sense anyway).

*BIG CAVEAT:* Remember that not all readers may want to click on hyperlinks in PDFs. You may therefore sometimes want to _remove_ `withhyper`, and spell out the field URL details a bit more completely, e.g. `\github{github.com/your-id}`.

Anyway assuming that you _do_ keep `withhyper` enabled: For each field e.g. `\homepage{foobar.com}`, a `\homepagesymbol` has been defined, and the clickable hyperlink is generated by prepending the `\homepagehyperprefix` to `foobar.com`. The `\homepgehyperprefix` is defined to be `\https://`, so this generates the hyperlink `https://foobar.com`.

If your homepage doesn't use HTTPS yet, or if you want to use a different symbol, you can re-define them with
```latex
\renewcommand{\homepagehyperprefix}{http://}
\renewcommand{\homepagesymbol}{\faLink}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### New Information Fields

I've decided against adding definitions for too many fields and symbols in the `.cls` itself; otherwise we'll have all possible platforms in the world (and more services are born everyday!) within `altacv.cls` before we know it.

You can actually just typeset your own arbitrary information fields using the `\printinfo{symbol}{detail}[optional hyperlink prefix]` command within `\personalinfo`:

````latex
\printinfo{\faPaw}{Hey ho!}
\printinfo{\faGitLab}{your-handle}[https://gitlab.com/]
````

Or if you really prefer, you can define a new field yourself with `\NewInfoFiled{fieldname}{symbol}[optional hyperlink prefix]` before  using it:

````latex
\NewInfoField{gitlab}{\faGitlab}[https://gitlab.com/]
\gitlab{your_id}
````

For services and platforms like Mastodon where there isn't a straightforward relation between the more popular user ID or nickname and the hyperlink, you can use `\printinfo` directly e.g.

```latex
\printinfo{\faMastodon}{@username@instace}[https://instance.url/@username]
```

But if you absolutely want to create new dedicated info fields for such platforms, then use `\NewInfoField*` with a star:

```latex
\NewInfoField*{mastodon}{\faMastodon}
```

then you can use `\mastodon` with TWO arguments where the 2nd argument is the full hyperlink.

```latex
\mastodon{@username@instance}{https://instance.url/@username}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Configurable colours

Use `\colorlet` or `\definecolor` to change these; see examples 
in preamble of `template.tex`.
* `accent`
* `emphasis`
* `heading`
* `headingrule`
* `subheading`
* `body`
* `name`
* `tagline`

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Configurable fonts

Use `\renewcommand` to change these; see examples in preamble of
`sample.tex`.
* `\namefont`
* `\taglinefont`
* `\personalinfofont`
* `\cvsectionfont`
* `\cvsubsectionfont`

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Configurable icons

Use `\renewcommand` to change these; see examples in preamble of
`sample.tex`.
* `\cvItemMarker` (bullets for `itemize`)
* `\cvRatingMarker` (for `\cvskill`)
* `\cvDateMarker` (for date in `\cvevent`)
* `\cvLocationMarker` (for location in `\cvevent` and `\location`)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



### Is this template ATS-friendly?
There is some discussion about this in issue #76. No actual claims are made, because we don't really know how each ATS system works. But this template uses `accsupp` to add replacement text for the icons, which may help — e.g. the `\faGithub` icon rendered in the PDF would copy-and-paste from Acrobat Reader, as exactly the text `\faGithub`. 

You could try running `pdftotext -raw sample.pdf` to view the text-only version of the CV, with the columnar layout removed.

Alternatively running `pdftotext -layout sample.pdf` to view the text-only version in a pseudo-two-column layout.

In particular `\locationname` and `\datename` hold the replacement text for the location and date/duration icon in `\cvevent`. These can be re-defined especially if your CV is in a non-English language, e.g. Spanish (see commented examples in preamble of `sample.tex`):

```latex
\renewcommand{\locationname}{Ubicación}
\renewcommand{\datename}{Fecha}
```

<p align="right">(<a href="#readme-top">back to top</a>)</p>

---



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Naveen Dharmathunga - [@XerDuke](https://x.com/dharmathunga) - dasheenaveen@outlook.com

Project Link: <https://github.com/D-Naveenz/NextCV>

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

* [Latex Team](https://www.latex-project.org/about/team/)
* [Img Shields](https://shields.io)
* [Font Awesome](https://fontawesome.com)
* [LianTze Lim](https://github.com/liantze) (Author of AltaCV)

<p align="right">(<a href="#readme-top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/D-Naveenz/NextCV.svg?style=for-the-badge
[contributors-url]: https://github.com/D-Naveenz/NextCV/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/D-Naveenz/NextCV.svg?style=for-the-badge
[forks-url]: https://github.com/D-Naveenz/NextCV/network/members
[stars-shield]: https://img.shields.io/github/stars/D-Naveenz/NextCV.svg?style=for-the-badge
[stars-url]: https://github.com/D-Naveenz/NextCV/stargazers
[issues-shield]: https://img.shields.io/github/issues/D-Naveenz/NextCV.svg?style=for-the-badge
[issues-url]: https://github.com/D-Naveenz/NextCV/issues
[license-shield]: https://img.shields.io/github/license/D-Naveenz/NextCV.svg?style=for-the-badge
[license-url]: https://github.com/D-Naveenz/NextCV/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://www.linkedin.com/in/dasheewd/
[latex-shield]: https://img.shields.io/badge/latex-%23008080.svg?style=for-the-badge&logo=latex&logoColor=white
[Latex-url]: https://www.latex-project.org/